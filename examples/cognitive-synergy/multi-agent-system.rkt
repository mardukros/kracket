#lang racket

;; Multi-Agent System - Emergent Cognitive Behavior
;; Demonstrates how multiple autonomous cognitive agents interact to
;; produce emergent intelligent behavior through cooperation, competition,
;; and communication.

(require racket/async-channel)

(provide (all-defined-out))

;; ============================================================================
;; SHARED WORLD & MESSAGE STRUCTURES
;; ============================================================================

(struct world-state
  (resources agents-positions messages time-step)
  #:mutable
  #:transparent)

(struct resource (type position value) #:transparent)
(struct agent-message (from to content timestamp) #:transparent)
(struct position (x y) #:transparent)

;; Message types
(struct msg-request-help (task-type urgency) #:transparent)
(struct msg-offer-cooperation (task-type) #:transparent)
(struct msg-share-knowledge (knowledge) #:transparent)
(struct msg-claim-resource (resource-id) #:transparent)

;; ============================================================================
;; COGNITIVE AGENT
;; ============================================================================

(struct cognitive-agent
  (id
   agent-type          ; 'explorer, 'gatherer, 'researcher
   position
   energy
   knowledge-base
   goals
   message-queue
   cooperation-history)
  #:mutable
  #:transparent)

(define (create-agent id type pos)
  (cognitive-agent
   id
   type
   pos
   100.0              ; Starting energy
   (make-hash)        ; Knowledge base
   '()                ; Goals
   (make-async-channel) ; Message queue
   (make-hash)))      ; Cooperation history

;; Agent perception of world
(define (perceive-world agent world)
  (define pos (cognitive-agent-position agent))
  (define resources (world-state-resources world))
  
  ;; Find nearby resources (within distance 3)
  (define nearby-resources
    (filter
     (lambda (r)
       (< (distance pos (resource-position r)) 3.0))
     resources))
  
  ;; Check messages
  (define messages '())
  (let loop ()
    (when (async-channel-try-get (cognitive-agent-message-queue agent))
      (set! messages (cons (async-channel-try-get (cognitive-agent-message-queue agent))
                          messages))
      (loop)))
  
  (hash 'nearby-resources nearby-resources
        'messages messages
        'energy (cognitive-agent-energy agent)
        'position pos))

;; Distance calculation
(define (distance pos1 pos2)
  (sqrt (+ (expt (- (position-x pos2) (position-x pos1)) 2)
           (expt (- (position-y pos2) (position-y pos1)) 2))))

;; Agent reasoning about actions
(define (reason-action agent percepts world)
  (define agent-type (cognitive-agent-agent-type agent))
  (define nearby-resources (hash-ref percepts 'nearby-resources))
  (define messages (hash-ref percepts 'messages))
  (define energy (hash-ref percepts 'energy))
  
  (cond
    ;; Low energy - seek resources
    [(< energy 30.0)
     (if (empty? nearby-resources)
         'explore-for-resources
         'gather-resource)]
    
    ;; Explorer agents explore
    [(eq? agent-type 'explorer)
     (if (< (random) 0.3)
         'explore-new-area
         'share-knowledge)]
    
    ;; Gatherer agents gather
    [(eq? agent-type 'gatherer)
     (if (empty? nearby-resources)
         'request-help
         'gather-resource)]
    
    ;; Researcher agents analyze
    [(eq? agent-type 'researcher)
     (if (< (random) 0.4)
         'analyze-data
         'cooperate)]
    
    [else 'idle]))

;; Execute agent action
(define (execute-action agent action world)
  (match action
    ['explore-for-resources
     (printf "[Agent ~a] Exploring for resources...\n" (cognitive-agent-id agent))
     (move-randomly agent)
     (consume-energy agent 2.0)]
    
    ['explore-new-area
     (printf "[Agent ~a] Exploring new area...\n" (cognitive-agent-id agent))
     (move-randomly agent)
     (consume-energy agent 1.5)]
    
    ['gather-resource
     (define nearby (filter
                     (lambda (r)
                       (< (distance (cognitive-agent-position agent)
                                   (resource-position r))
                          1.0))
                     (world-state-resources world)))
     (when (not (empty? nearby))
       (define resource (car nearby))
       (printf "[Agent ~a] Gathering ~a (value: ~a)\n"
               (cognitive-agent-id agent)
               (resource-type resource)
               (resource-value resource))
       (gain-energy agent (* 0.5 (resource-value resource)))
       (remove-resource world resource))
     (consume-energy agent 1.0)]
    
    ['share-knowledge
     (printf "[Agent ~a] Broadcasting knowledge...\n" (cognitive-agent-id agent))
     (broadcast-knowledge agent world)
     (consume-energy agent 0.5)]
    
    ['request-help
     (printf "[Agent ~a] Requesting help...\n" (cognitive-agent-id agent))
     (request-help agent world)
     (consume-energy agent 0.3)]
    
    ['cooperate
     (printf "[Agent ~a] Looking for cooperation opportunity...\n"
             (cognitive-agent-id agent))
     (offer-cooperation agent world)
     (consume-energy agent 0.5)]
    
    ['analyze-data
     (printf "[Agent ~a] Analyzing collected data...\n" (cognitive-agent-id agent))
     (analyze-knowledge agent)
     (consume-energy agent 1.0)]
    
    ['idle
     (printf "[Agent ~a] Idle, conserving energy...\n" (cognitive-agent-id agent))
     (consume-energy agent 0.1)]
    
    [_
     (printf "[Agent ~a] Unknown action: ~a\n" (cognitive-agent-id agent) action)]))

;; ============================================================================
;; AGENT BEHAVIORS
;; ============================================================================

(define (move-randomly agent)
  (define current-pos (cognitive-agent-position agent))
  (define dx (- (random) 0.5))
  (define dy (- (random) 0.5))
  (define new-pos
    (position
     (max 0 (min 10 (+ (position-x current-pos) dx)))
     (max 0 (min 10 (+ (position-y current-pos) dy)))))
  (set-cognitive-agent-position! agent new-pos))

(define (consume-energy agent amount)
  (set-cognitive-agent-energy!
   agent
   (max 0 (- (cognitive-agent-energy agent) amount))))

(define (gain-energy agent amount)
  (set-cognitive-agent-energy!
   agent
   (min 100 (+ (cognitive-agent-energy agent) amount))))

(define (broadcast-knowledge agent world)
  (define knowledge (cognitive-agent-knowledge-base agent))
  (define other-agents
    (filter
     (lambda (a) (not (eq? (cognitive-agent-id a) (cognitive-agent-id agent))))
     (hash-values (world-state-agents-positions world))))
  
  (for ([other other-agents])
    (send-message agent other (msg-share-knowledge knowledge))))

(define (request-help agent world)
  (define other-agents
    (filter
     (lambda (a) (not (eq? (cognitive-agent-id a) (cognitive-agent-id agent))))
     (hash-values (world-state-agents-positions world))))
  
  (for ([other other-agents])
    (send-message agent other (msg-request-help 'gathering 'high))))

(define (offer-cooperation agent world)
  (define other-agents
    (filter
     (lambda (a) (not (eq? (cognitive-agent-id a) (cognitive-agent-id agent))))
     (hash-values (world-state-agents-positions world))))
  
  (for ([other other-agents])
    (send-message agent other (msg-offer-cooperation 'research))))

(define (analyze-knowledge agent)
  (define kb (cognitive-agent-knowledge-base agent))
  (hash-set! kb 'analysis-count (+ 1 (hash-ref kb 'analysis-count 0)))
  (hash-set! kb 'last-analysis (current-seconds)))

(define (send-message from-agent to-agent content)
  (define msg (agent-message
               (cognitive-agent-id from-agent)
               (cognitive-agent-id to-agent)
               content
               (current-seconds)))
  (async-channel-put (cognitive-agent-message-queue to-agent) msg))

(define (remove-resource world resource)
  (set-world-state-resources!
   world
   (filter (lambda (r) (not (equal? r resource)))
           (world-state-resources world))))

;; ============================================================================
;; WORLD SIMULATION
;; ============================================================================

(define (create-world)
  (world-state
   ;; Initial resources
   (list
    (resource 'food (position 2 3) 10)
    (resource 'food (position 7 8) 15)
    (resource 'energy (position 5 5) 20)
    (resource 'knowledge (position 1 9) 8)
    (resource 'food (position 9 2) 12))
   ;; Agents positions (hash: id -> agent)
   (make-hash)
   ;; Messages
   '()
   ;; Time step
   0))

(define (add-agent world agent)
  (hash-set! (world-state-agents-positions world)
             (cognitive-agent-id agent)
             agent))

(define (simulate-step world)
  (define time-step (world-state-time-step world))
  (printf "\n=== Time Step ~a ===\n" time-step)
  
  ;; Each agent perceives, reasons, and acts
  (define agents (hash-values (world-state-agents-positions world)))
  
  (for ([agent agents])
    (when (> (cognitive-agent-energy agent) 0)
      (define percepts (perceive-world agent world))
      (define action (reason-action agent percepts world))
      (execute-action agent action world)))
  
  ;; Update world state
  (set-world-state-time-step! world (+ 1 time-step))
  
  ;; Add new resources occasionally
  (when (zero? (modulo time-step 3))
    (add-random-resource world))
  
  ;; Print world summary
  (print-world-summary world))

(define (add-random-resource world)
  (define resource-types '(food energy knowledge))
  (define new-resource
    (resource
     (list-ref resource-types (random (length resource-types)))
     (position (random 11) (random 11))
     (+ 5 (random 15))))
  (set-world-state-resources!
   world
   (cons new-resource (world-state-resources world)))
  (printf "[WORLD] New ~a resource appeared at (~a, ~a)\n"
          (resource-type new-resource)
          (position-x (resource-position new-resource))
          (position-y (resource-position new-resource))))

(define (print-world-summary world)
  (define agents (hash-values (world-state-agents-positions world)))
  (define total-energy (apply + (map cognitive-agent-energy agents)))
  (define avg-energy (/ total-energy (length agents)))
  (define resources (length (world-state-resources world)))
  
  (printf "\n[SUMMARY] Agents: ~a | Avg Energy: ~a | Resources: ~a\n"
          (length agents)
          (real->decimal-string avg-energy 1)
          resources)
  
  (for ([agent agents])
    (printf "  Agent ~a (~a): Energy=~a, Pos=(~a,~a)\n"
            (cognitive-agent-id agent)
            (cognitive-agent-agent-type agent)
            (real->decimal-string (cognitive-agent-energy agent) 1)
            (real->decimal-string (position-x (cognitive-agent-position agent)) 1)
            (real->decimal-string (position-y (cognitive-agent-position agent)) 1))))

;; ============================================================================
;; DEMONSTRATION
;; ============================================================================

(define (run-multi-agent-demo)
  (printf "\n")
  (printf "╔════════════════════════════════════════════════════════╗\n")
  (printf "║   MULTI-AGENT COGNITIVE SYSTEM                         ║\n")
  (printf "║   Emergent Behavior Through Agent Interaction          ║\n")
  (printf "╚════════════════════════════════════════════════════════╝\n\n")
  
  (printf "This demo shows multiple autonomous cognitive agents\n")
  (printf "interacting in a shared environment, demonstrating:\n")
  (printf "  • Autonomous decision making\n")
  (printf "  • Resource competition and cooperation\n")
  (printf "  • Inter-agent communication\n")
  (printf "  • Emergent collective behavior\n\n")
  
  ;; Create world
  (define world (create-world))
  
  ;; Create agents
  (define explorer1 (create-agent 'E1 'explorer (position 1 1)))
  (define explorer2 (create-agent 'E2 'explorer (position 9 9)))
  (define gatherer1 (create-agent 'G1 'gatherer (position 5 2)))
  (define gatherer2 (create-agent 'G2 'gatherer (position 3 8)))
  (define researcher1 (create-agent 'R1 'researcher (position 5 5)))
  
  ;; Add agents to world
  (add-agent world explorer1)
  (add-agent world explorer2)
  (add-agent world gatherer1)
  (add-agent world gatherer2)
  (add-agent world researcher1)
  
  (printf "Created 5 cognitive agents:\n")
  (printf "  • 2 Explorers (discover new areas & share knowledge)\n")
  (printf "  • 2 Gatherers (collect resources efficiently)\n")
  (printf "  • 1 Researcher (analyze data & coordinate)\n\n")
  
  ;; Run simulation for 8 time steps
  (for ([i 8])
    (simulate-step world)
    (sleep 0.5))
  
  (printf "\n")
  (printf "╔════════════════════════════════════════════════════════╗\n")
  (printf "║   SIMULATION COMPLETE                                  ║\n")
  (printf "╚════════════════════════════════════════════════════════╝\n\n")
  
  (printf "Emergent Behaviors Observed:\n")
  (printf "  • Agents adapt strategies based on energy levels\n")
  (printf "  • Different agent types exhibit specialized behaviors\n")
  (printf "  • Communication enables knowledge sharing\n")
  (printf "  • Competition for resources drives exploration\n")
  (printf "  • Collective intelligence emerges from simple rules\n\n"))

;; Run the demo if this file is executed directly
(module+ main
  (run-multi-agent-demo))
