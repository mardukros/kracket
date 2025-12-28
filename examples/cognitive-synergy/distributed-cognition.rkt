#lang racket

;; Distributed Cognition Demo - Multi-Process Cognitive Architecture
;; Demonstrates how cognitive processes can be distributed across multiple
;; Racket places (OS processes) for parallel cognitive processing with
;; message-based coordination.

(require racket/place
         racket/async-channel)

(provide (all-defined-out))

;; ============================================================================
;; SHARED DATA STRUCTURES
;; ============================================================================

;; Message types for inter-cognitive communication
(struct cognitive-message (from to type data timestamp) #:prefab)
(struct perception-request (stimulus id) #:prefab)
(struct perception-result (percept confidence id) #:prefab)
(struct reasoning-request (beliefs id) #:prefab)
(struct reasoning-result (conclusion confidence id) #:prefab)
(struct action-request (action-type parameters id) #:prefab)
(struct action-result (success outcome id) #:prefab)

;; ============================================================================
;; PERCEPTION COGNITIVE AGENT (runs in separate place)
;; ============================================================================

(define (perception-agent-place channel)
  (printf "[PERCEPTION AGENT] Starting in place ~a\n" (current-process-id))
  
  (define (process-stimulus stimulus)
    (printf "[PERCEPTION] Processing: ~a\n" stimulus)
    (cond
      [(string? stimulus)
       (values (string-append "Text: " stimulus) 0.9)]
      [(number? stimulus)
       (values (format "Number: ~a" stimulus) 0.95)]
      [(list? stimulus)
       (values (format "List of ~a items" (length stimulus)) 0.85)]
      [else
       (values (format "Unknown: ~a" stimulus) 0.5)]))
  
  ;; Agent processing loop
  (let loop ()
    (define msg (place-channel-get channel))
    (match msg
      [(perception-request stimulus id)
       (printf "[PERCEPTION] Received request ~a\n" id)
       (define-values (percept conf) (process-stimulus stimulus))
       (place-channel-put channel
                          (perception-result percept conf id))
       (printf "[PERCEPTION] Sent result for request ~a\n" id)]
      
      ['shutdown
       (printf "[PERCEPTION AGENT] Shutting down\n")]
      
      [_
       (printf "[PERCEPTION] Unknown message: ~a\n" msg)
       (loop)])))

;; ============================================================================
;; REASONING COGNITIVE AGENT (runs in separate place)
;; ============================================================================

(define (reasoning-agent-place channel)
  (printf "[REASONING AGENT] Starting in place ~a\n" (current-process-id))
  
  ;; Simple reasoning rules
  (define rules
    '((text-percept . "Process natural language")
      (number-percept . "Perform mathematical analysis")
      (list-percept . "Detect patterns and sequences")
      (unknown-percept . "Request more information")))
  
  (define (apply-reasoning beliefs)
    (printf "[REASONING] Applying inference to: ~a\n" beliefs)
    (cond
      [(string-contains? beliefs "Text")
       (values "Language understanding activated" 0.88)]
      [(string-contains? beliefs "Number")
       (values "Mathematical reasoning activated" 0.92)]
      [(string-contains? beliefs "List")
       (values "Pattern recognition activated" 0.85)]
      [else
       (values "General reasoning activated" 0.7)]))
  
  ;; Agent processing loop
  (let loop ()
    (define msg (place-channel-get channel))
    (match msg
      [(reasoning-request beliefs id)
       (printf "[REASONING] Received request ~a\n" id)
       (define-values (conclusion conf) (apply-reasoning beliefs))
       (place-channel-put channel
                          (reasoning-result conclusion conf id))
       (printf "[REASONING] Sent result for request ~a\n" id)]
      
      ['shutdown
       (printf "[REASONING AGENT] Shutting down\n")]
      
      [_
       (printf "[REASONING] Unknown message: ~a\n" msg)
       (loop)])))

;; ============================================================================
;; ACTION COGNITIVE AGENT (runs in separate place)
;; ============================================================================

(define (action-agent-place channel)
  (printf "[ACTION AGENT] Starting in place ~a\n" (current-process-id))
  
  (define (execute-action action-type params)
    (printf "[ACTION] Executing: ~a with params: ~a\n" action-type params)
    (match action-type
      ['speak
       (values #t (format "Speaking: ~a" params))]
      ['move
       (values #t (format "Moving to: ~a" params))]
      ['store
       (values #t (format "Storing: ~a" params))]
      [_
       (values #f (format "Unknown action: ~a" action-type))]))
  
  ;; Agent processing loop
  (let loop ()
    (define msg (place-channel-get channel))
    (match msg
      [(action-request action-type params id)
       (printf "[ACTION] Received request ~a\n" id)
       (define-values (success outcome) (execute-action action-type params))
       (place-channel-put channel
                          (action-result success outcome id))
       (printf "[ACTION] Sent result for request ~a\n" id)]
      
      ['shutdown
       (printf "[ACTION AGENT] Shutting down\n")]
      
      [_
       (printf "[ACTION] Unknown message: ~a\n" msg)
       (loop)])))

;; ============================================================================
;; COORDINATOR (main cognitive orchestrator)
;; ============================================================================

(struct distributed-cognitive-system
  (perception-place reasoning-place action-place request-counter)
  #:mutable
  #:transparent)

(define (create-distributed-cognitive-system)
  (printf "[COORDINATOR] Creating distributed cognitive system...\n")
  
  ;; Start perception agent in separate place
  (define perception-place
    (dynamic-place (quote-module-path)
                   'perception-agent-place))
  
  ;; Start reasoning agent in separate place
  (define reasoning-place
    (dynamic-place (quote-module-path)
                   'reasoning-agent-place))
  
  ;; Start action agent in separate place
  (define action-place
    (dynamic-place (quote-module-path)
                   'action-agent-place))
  
  (printf "[COORDINATOR] All cognitive agents started\n")
  
  (distributed-cognitive-system
   perception-place
   reasoning-place
   action-place
   0))

(define (generate-request-id sys)
  (set-distributed-cognitive-system-request-counter!
   sys
   (+ 1 (distributed-cognitive-system-request-counter sys)))
  (distributed-cognitive-system-request-counter sys))

;; Perceive: Send stimulus to perception agent
(define (distributed-perceive sys stimulus)
  (define id (generate-request-id sys))
  (define perc-place (distributed-cognitive-system-perception-place sys))
  
  (printf "[COORDINATOR] Sending perception request ~a\n" id)
  (place-channel-put perc-place (perception-request stimulus id))
  
  (define result (place-channel-get perc-place))
  (printf "[COORDINATOR] Received perception result ~a\n" id)
  result)

;; Reason: Send beliefs to reasoning agent
(define (distributed-reason sys beliefs)
  (define id (generate-request-id sys))
  (define reason-place (distributed-cognitive-system-reasoning-place sys))
  
  (printf "[COORDINATOR] Sending reasoning request ~a\n" id)
  (place-channel-put reason-place (reasoning-request beliefs id))
  
  (define result (place-channel-get reason-place))
  (printf "[COORDINATOR] Received reasoning result ~a\n" id)
  result)

;; Act: Send action to action agent
(define (distributed-act sys action-type params)
  (define id (generate-request-id sys))
  (define act-place (distributed-cognitive-system-action-place sys))
  
  (printf "[COORDINATOR] Sending action request ~a\n" id)
  (place-channel-put act-place (action-request action-type params id))
  
  (define result (place-channel-get act-place))
  (printf "[COORDINATOR] Received action result ~a\n" id)
  result)

;; Shutdown the distributed system
(define (shutdown-distributed-system sys)
  (printf "[COORDINATOR] Shutting down distributed cognitive system...\n")
  
  (place-channel-put (distributed-cognitive-system-perception-place sys) 'shutdown)
  (place-channel-put (distributed-cognitive-system-reasoning-place sys) 'shutdown)
  (place-channel-put (distributed-cognitive-system-action-place sys) 'shutdown)
  
  (place-wait (distributed-cognitive-system-perception-place sys))
  (place-wait (distributed-cognitive-system-reasoning-place sys))
  (place-wait (distributed-cognitive-system-action-place sys))
  
  (printf "[COORDINATOR] All agents shut down\n"))

;; ============================================================================
;; COGNITIVE CYCLE - Distributed version
;; ============================================================================

(define (distributed-cognitive-cycle sys input)
  (printf "\n========================================\n")
  (printf "DISTRIBUTED COGNITIVE CYCLE\n")
  (printf "Input: ~a\n" input)
  (printf "========================================\n\n")
  
  ;; Step 1: Distributed Perception
  (define percept-result (distributed-perceive sys input))
  (match-define (perception-result percept confidence _) percept-result)
  (printf "\n[CYCLE] Perception complete: ~a (confidence: ~a)\n" percept confidence)
  
  ;; Step 2: Distributed Reasoning
  (define reasoning-result (distributed-reason sys percept))
  (match-define (reasoning-result conclusion conf _) reasoning-result)
  (printf "\n[CYCLE] Reasoning complete: ~a (confidence: ~a)\n" conclusion conf)
  
  ;; Step 3: Distributed Action
  (define action-type (if (> conf 0.8) 'speak 'store))
  (define action-result (distributed-act sys action-type conclusion))
  (match-define (action-result success outcome _) action-result)
  (printf "\n[CYCLE] Action complete: ~a\n" outcome)
  
  (printf "\n========================================\n")
  (printf "CYCLE COMPLETE - Result: ~a\n" outcome)
  (printf "========================================\n\n")
  
  outcome)

;; ============================================================================
;; DEMONSTRATION
;; ============================================================================

(define (run-distributed-cognition-demo)
  (printf "\n")
  (printf "╔════════════════════════════════════════════════════════╗\n")
  (printf "║   DISTRIBUTED COGNITION DEMONSTRATION                  ║\n")
  (printf "║   Multi-Process Cognitive Architecture                 ║\n")
  (printf "╚════════════════════════════════════════════════════════╝\n\n")
  
  (printf "This demo shows cognitive processes distributed across\n")
  (printf "multiple OS processes (Racket places) with message-based\n")
  (printf "coordination for parallel cognitive processing.\n\n")
  
  ;; Create the distributed system
  (define sys (create-distributed-cognitive-system))
  
  (printf "\n--- Test 1: Text Input ---\n")
  (distributed-cognitive-cycle sys "Hello, distributed cognition!")
  
  (sleep 1)
  
  (printf "\n--- Test 2: Numeric Input ---\n")
  (distributed-cognitive-cycle sys 42)
  
  (sleep 1)
  
  (printf "\n--- Test 3: List Input ---\n")
  (distributed-cognitive-cycle sys '(1 2 3 4 5))
  
  (sleep 1)
  
  ;; Shutdown
  (shutdown-distributed-system sys)
  
  (printf "\n")
  (printf "╔════════════════════════════════════════════════════════╗\n")
  (printf "║   DEMONSTRATION COMPLETE                               ║\n")
  (printf "╚════════════════════════════════════════════════════════╝\n\n")
  
  (printf "Key Concepts Demonstrated:\n")
  (printf "  • Distributed cognitive processing across OS processes\n")
  (printf "  • Message-based inter-agent communication\n")
  (printf "  • Parallel cognitive operations\n")
  (printf "  • Coordinated multi-agent architecture\n")
  (printf "  • Scalable cognitive system design\n\n"))

;; Run the demo if this file is executed directly
(module+ main
  (run-distributed-cognition-demo))
