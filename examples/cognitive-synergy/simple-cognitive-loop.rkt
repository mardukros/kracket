#lang racket

;; Simple Cognitive Loop - Demonstrating Basic Cognitive Synergy
;; This example shows how perception, reasoning, and action components
;; work together to create emergent intelligent behavior.

(provide (all-defined-out))

;; ============================================================================
;; PERCEPTION MODULE
;; ============================================================================

(struct percept (type data confidence) #:transparent)

(define (perceive-environment input)
  (printf "[PERCEPTION] Processing input: ~a\n" input)
  
  ;; Simulate multi-modal perception
  (define percepts
    (cond
      [(string? input)
       (list (percept 'text input 0.9))]
      [(number? input)
       (list (percept 'numeric input 0.95))]
      [(list? input)
       (for/list ([item input])
         (percept 'sequence item 0.8))]
      [else
       (list (percept 'unknown input 0.5))]))
  
  (printf "[PERCEPTION] Generated ~a percept(s)\n" (length percepts))
  percepts)

;; ============================================================================
;; REASONING MODULE  
;; ============================================================================

(struct belief (proposition confidence source) #:transparent)

(define knowledge-base
  (make-hash
   '((rule1 . "If perceive text, then understand language")
     (rule2 . "If perceive number, then perform calculation")
     (rule3 . "If perceive sequence, then recognize pattern"))))

(define (reason-about percepts)
  (printf "[REASONING] Analyzing ~a percept(s)\n" (length percepts))
  
  ;; Pattern matching for inference
  (define beliefs
    (for/list ([p percepts])
      (match (percept-type p)
        ['text
         (belief 'language-detected 
                 (percept-confidence p)
                 'perception)]
        ['numeric
         (belief 'quantity-detected
                 (percept-confidence p)
                 'perception)]
        ['sequence
         (belief 'pattern-detected
                 (percept-confidence p)
                 'perception)]
        [_
         (belief 'unknown-input
                 (* (percept-confidence p) 0.5)
                 'perception)])))
  
  ;; Apply knowledge base rules
  (define enhanced-beliefs
    (for/list ([b beliefs])
      (define rule (hash-ref knowledge-base 
                             (string->symbol 
                              (format "rule~a" 
                                     (+ 1 (random 3))))
                             "No rule"))
      (printf "[REASONING] Applied rule: ~a\n" rule)
      b))
  
  (printf "[REASONING] Generated ~a belief(s)\n" (length enhanced-beliefs))
  enhanced-beliefs)

;; ============================================================================
;; ACTION SELECTION MODULE
;; ============================================================================

(struct action (type parameters priority) #:transparent)

(define (select-action beliefs)
  (printf "[ACTION] Selecting action based on ~a belief(s)\n" 
          (length beliefs))
  
  ;; Choose action based on beliefs
  (define actions
    (for/list ([b beliefs])
      (match (belief-proposition b)
        ['language-detected
         (action 'respond-text 
                 (list "I understand your message")
                 (belief-confidence b))]
        ['quantity-detected
         (action 'compute
                 (list "performing calculation")
                 (belief-confidence b))]
        ['pattern-detected
         (action 'analyze-pattern
                 (list "recognizing patterns")
                 (belief-confidence b))]
        [_
         (action 'ask-clarification
                 (list "please clarify")
                 (* (belief-confidence b) 0.5))])))
  
  ;; Select highest priority action
  (define best-action
    (argmax action-priority actions))
  
  (printf "[ACTION] Selected: ~a with priority ~a\n"
          (action-type best-action)
          (action-priority best-action))
  
  best-action)

;; ============================================================================
;; LEARNING MODULE - Demonstrates Meta-Cognition
;; ============================================================================

(struct experience (input output success?) #:transparent)

(define experience-memory '())

(define (learn-from-experience input output success?)
  (printf "[LEARNING] Recording experience (success: ~a)\n" success?)
  
  ;; Store experience
  (set! experience-memory
        (cons (experience input output success?)
              experience-memory))
  
  ;; Meta-learning: analyze patterns in experiences
  (when (>= (length experience-memory) 5)
    (define success-rate
      (/ (count (lambda (e) (experience-success? e)) 
                experience-memory)
         (length experience-memory)))
    (printf "[LEARNING] Success rate: ~a\n" success-rate)
    
    ;; Adapt behavior based on success rate
    (when (< success-rate 0.5)
      (printf "[LEARNING] Low success rate! Adapting strategies...\n"))))

;; ============================================================================
;; COGNITIVE CYCLE - The Synergy Emerges Here
;; ============================================================================

(define (cognitive-cycle input)
  (printf "\n========================================\n")
  (printf "COGNITIVE CYCLE START\n")
  (printf "========================================\n\n")
  
  ;; 1. PERCEIVE
  (define percepts (perceive-environment input))
  
  ;; 2. REASON (uses percepts)
  (define beliefs (reason-about percepts))
  
  ;; 3. ACT (uses beliefs)
  (define selected-action (select-action beliefs))
  
  ;; 4. EXECUTE
  (printf "\n[EXECUTION] Performing action: ~a\n" 
          (action-type selected-action))
  (printf "[EXECUTION] Parameters: ~a\n"
          (action-parameters selected-action))
  
  ;; 5. LEARN (feedback loop - creates synergy)
  (define success? (> (action-priority selected-action) 0.7))
  (learn-from-experience input selected-action success?)
  
  (printf "\n========================================\n")
  (printf "COGNITIVE CYCLE END\n")
  (printf "========================================\n\n")
  
  ;; Return action for inspection
  selected-action)

;; ============================================================================
;; DEMONSTRATION - Shows Emergent Behavior
;; ============================================================================

(define (demonstrate-cognitive-synergy)
  (printf "===========================================\n")
  (printf "COGNITIVE SYNERGY DEMONSTRATION\n")
  (printf "===========================================\n\n")
  
  (printf "This demonstrates how PERCEPTION, REASONING, and ACTION\n")
  (printf "work together to create EMERGENT INTELLIGENCE.\n\n")
  
  ;; Test different inputs
  (cognitive-cycle "Hello, how are you?")
  (cognitive-cycle 42)
  (cognitive-cycle '(1 2 3 4 5))
  (cognitive-cycle "I need help")
  
  ;; Show learned patterns
  (printf "\n===========================================\n")
  (printf "LEARNED PATTERNS:\n")
  (printf "===========================================\n")
  (printf "Total experiences: ~a\n" (length experience-memory))
  (printf "Experience memory demonstrates LEARNING synergy\n")
  (printf "with other cognitive components.\n\n"))

;; ============================================================================
;; SYNERGY ANALYSIS - Meta-Level View
;; ============================================================================

(define (analyze-synergy)
  (printf "===========================================\n")
  (printf "SYNERGY ANALYSIS\n")
  (printf "===========================================\n\n")
  
  (printf "Key Synergies Demonstrated:\n\n")
  
  (printf "1. PERCEPTION → REASONING\n")
  (printf "   Percepts feed beliefs, enabling interpretation\n\n")
  
  (printf "2. REASONING → ACTION\n")
  (printf "   Beliefs guide action selection, enabling purposeful behavior\n\n")
  
  (printf "3. ACTION → LEARNING\n")
  (printf "   Actions create feedback, enabling adaptation\n\n")
  
  (printf "4. LEARNING → ALL COMPONENTS\n")
  (printf "   Experience shapes future processing (meta-cognition)\n\n")
  
  (printf "5. EMERGENT PROPERTY: INTELLIGENCE\n")
  (printf "   None of these components alone is 'intelligent'\n")
  (printf "   Intelligence EMERGES from their INTEGRATION\n\n")
  
  (printf "This is COGNITIVE SYNERGY in action!\n"))

;; ============================================================================
;; MAIN - Run the demonstration
;; ============================================================================

(module+ main
  (demonstrate-cognitive-synergy)
  (analyze-synergy))
