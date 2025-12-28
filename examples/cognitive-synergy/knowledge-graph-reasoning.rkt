#lang racket

;; Knowledge Graph Reasoning - Symbolic AI with S-expressions
;; Demonstrates how S-expressions provide natural knowledge representation
;; and enable powerful symbolic reasoning through pattern matching

(provide (all-defined-out))

;; ============================================================================
;; KNOWLEDGE REPRESENTATION
;; ============================================================================

;; Knowledge is represented as S-expressions (symbolic expressions)
;; This demonstrates Racket's homoiconicity - code is data, data is code

(struct triple (subject predicate object) #:transparent)
(struct truth-value (strength confidence) #:transparent)
(struct fact (triple tv) #:transparent)

;; Knowledge base as list of facts
(define knowledge-base
  (list
   ;; Concepts and their properties
   (fact (triple 'Socrates 'is-a 'Human)
         (truth-value 1.0 0.95))
   (fact (triple 'Human 'is-a 'Mammal)
         (truth-value 0.99 0.90))
   (fact (triple 'Mammal 'is-a 'Animal)
         (truth-value 1.0 0.95))
   (fact (triple 'Animal 'is-a 'LivingThing)
         (truth-value 1.0 0.95))
   
   ;; Properties
   (fact (triple 'Human 'has-property 'Rational)
         (truth-value 0.90 0.80))
   (fact (triple 'Mammal 'has-property 'WarmBlooded)
         (truth-value 1.0 0.95))
   (fact (triple 'Animal 'has-property 'Mortal)
         (truth-value 0.99 0.90))
   
   ;; Relationships
   (fact (triple 'Socrates 'taught 'Plato)
         (truth-value 0.95 0.85))
   (fact (triple 'Plato 'taught 'Aristotle)
         (truth-value 0.95 0.85))))

;; ============================================================================
;; PATTERN MATCHING FOR KNOWLEDGE QUERIES
;; ============================================================================

(define (query-knowledge pattern)
  (printf "\n[QUERY] Searching for pattern: ~a\n" pattern)
  
  (define matches
    (for/list ([f knowledge-base]
               #:when (match-pattern? (fact-triple f) pattern))
      f))
  
  (printf "[QUERY] Found ~a match(es)\n" (length matches))
  matches)

(define (match-pattern? triple pattern)
  (match pattern
    [(list subj pred obj)
     (and (or (equal? subj '_) (equal? subj (triple-subject triple)))
          (or (equal? pred '_) (equal? pred (triple-predicate triple)))
          (or (equal? obj '_) (equal? obj (triple-object triple))))]
    [_ #f]))

;; ============================================================================
;; INFERENCE RULES - Symbolic Reasoning
;; ============================================================================

;; Rule 1: Transitive Closure for 'is-a' relations
(define (infer-transitive kb)
  (printf "\n[INFERENCE] Applying transitive closure...\n")
  
  (define new-facts '())
  
  ;; Find all A is-a B and B is-a C, infer A is-a C
  (define seen-facts (make-hash))  ; Use hash for efficient duplicate checking
  
  (for* ([f1 kb]
         [f2 kb])
    (match* ((fact-triple f1) (fact-triple f2))
      [((triple a 'is-a b) (triple b-prime 'is-a c))
       #:when (equal? b b-prime)
       (define tv1 (fact-tv f1))
       (define tv2 (fact-tv f2))
       ;; Combined truth value (simplified)
       (define combined-strength 
         (* (truth-value-strength tv1) 
            (truth-value-strength tv2)))
       (define combined-confidence
         (min (truth-value-confidence tv1)
              (truth-value-confidence tv2)))
       (define new-fact
         (fact (triple a 'is-a c)
               (truth-value combined-strength combined-confidence)))
       
       ;; Check if already known using hash
       (define fact-key (cons a c))
       (unless (hash-has-key? seen-facts fact-key)
         (printf "[INFERENCE] Inferred: ~a is-a ~a (strength: ~a)\n"
                 a c combined-strength)
         (hash-set! seen-facts fact-key #t)
         (set! new-facts (cons new-fact new-facts)))]
      [(_ _) (void)]))
  
  new-facts)

;; Rule 2: Property Inheritance
(define (infer-property-inheritance kb)
  (printf "\n[INFERENCE] Applying property inheritance...\n")
  
  (define new-facts '())
  
  ;; If A is-a B and B has-property P, then A has-property P
  (define seen-facts (make-hash))  ; Use hash for efficient duplicate checking
  
  (for* ([f1 kb]
         [f2 kb])
    (match* ((fact-triple f1) (fact-triple f2))
      [((triple a 'is-a b) (triple b-prime 'has-property p))
       #:when (equal? b b-prime)
       (define tv1 (fact-tv f1))
       (define tv2 (fact-tv f2))
       (define combined-strength
         (* (truth-value-strength tv1)
            (truth-value-strength tv2)))
       (define combined-confidence
         (* (truth-value-confidence tv1)
              (truth-value-confidence tv2)
              0.9))  ; Discount for inheritance
       (define new-fact
         (fact (triple a 'has-property p)
               (truth-value combined-strength combined-confidence)))
       
       ;; Check if already known using hash
       (define fact-key (cons a p))
       (unless (hash-has-key? seen-facts fact-key)
         (printf "[INFERENCE] Inferred: ~a has-property ~a (strength: ~a)\n"
                 a p combined-strength)
         (hash-set! seen-facts fact-key #t)
         (set! new-facts (cons new-fact new-facts)))]
      [(_ _) (void)]))
  
  new-facts)

;; ============================================================================
;; FORWARD CHAINING - Iterative Inference
;; ============================================================================

(define (forward-chain kb max-iterations)
  (printf "\n========================================\n")
  (printf "FORWARD CHAINING INFERENCE\n")
  (printf "========================================\n")
  
  (define (iterate kb iteration)
    (if (>= iteration max-iterations)
        kb
        (begin
          (printf "\n--- Iteration ~a ---\n" iteration)
          (define new-facts-1 (infer-transitive kb))
          (define new-facts-2 (infer-property-inheritance kb))
          (define all-new-facts (append new-facts-1 new-facts-2))
          
          (if (null? all-new-facts)
              (begin
                (printf "\n[INFERENCE] No new facts derived. Converged!\n")
                kb)
              (iterate (append kb all-new-facts) (+ iteration 1))))))
  
  (iterate kb 0))

;; ============================================================================
;; BACKWARD CHAINING - Goal-Directed Reasoning
;; ============================================================================

(define (prove-goal goal kb)
  (printf "\n========================================\n")
  (printf "BACKWARD CHAINING: Proving goal\n")
  (printf "========================================\n")
  (printf "[GOAL] ~a\n\n" goal)
  
  (define (prove triple depth)
    (define indent (make-string (* depth 2) #\space))
    (printf "~a[PROVE] Attempting: ~a\n" indent triple)
    
    ;; Check if directly in KB
    (define direct-match
      (for/or ([f kb])
        (and (equal? (fact-triple f) triple) f)))
    
    (cond
      [direct-match
       (printf "~a[FOUND] Direct match in KB!\n" indent)
       (list direct-match)]
      
      ;; Try to prove via transitivity
      [(equal? (triple-predicate triple) 'is-a)
       (define a (triple-subject triple))
       (define c (triple-object triple))
       (printf "~a[STRATEGY] Try transitivity: find intermediate B\n" indent)
       
       (for/or ([b (find-intermediate-concepts kb)])
         (define proof1 (prove (triple a 'is-a b) (+ depth 1)))
         (and proof1
              (let ([proof2 (prove (triple b 'is-a c) (+ depth 1))])
                (and proof2
                     (begin
                       (printf "~a[SUCCESS] Proved via ~a!\n" indent b)
                       (append proof1 proof2))))))]
      
      [else
       (printf "~a[FAILED] Cannot prove\n" indent)
       #f]))
  
  (prove goal 0))

(define (find-intermediate-concepts kb)
  (remove-duplicates
   (append
    (map (compose triple-object fact-triple) kb)
    (map (compose triple-subject fact-triple) kb))))

;; ============================================================================
;; KNOWLEDGE GRAPH VISUALIZATION (Text-based)
;; ============================================================================

(define (visualize-knowledge kb)
  (printf "\n========================================\n")
  (printf "KNOWLEDGE GRAPH VISUALIZATION\n")
  (printf "========================================\n\n")
  
  ;; Group by predicate
  (define is-a-facts
    (filter (lambda (f) (equal? (triple-predicate (fact-triple f)) 'is-a)) kb))
  (define has-property-facts
    (filter (lambda (f) (equal? (triple-predicate (fact-triple f)) 'has-property)) kb))
  
  (printf "IS-A Hierarchy:\n")
  (for ([f is-a-facts])
    (define t (fact-triple f))
    (define tv (fact-tv f))
    (printf "  ~a → ~a [~a]\n" 
            (triple-subject t)
            (triple-object t)
            (truth-value-strength tv)))
  
  (printf "\nProperties:\n")
  (for ([f has-property-facts])
    (define t (fact-triple f))
    (define tv (fact-tv f))
    (printf "  ~a has ~a [~a]\n"
            (triple-subject t)
            (triple-object t)
            (truth-value-strength tv)))
  
  (printf "\n"))

;; ============================================================================
;; DEMONSTRATION
;; ============================================================================

(define (demonstrate-knowledge-reasoning)
  (printf "\n╔══════════════════════════════════════════╗\n")
  (printf "║  KNOWLEDGE GRAPH REASONING DEMO          ║\n")
  (printf "╚══════════════════════════════════════════╝\n")
  
  ;; Show initial knowledge
  (printf "\n[INITIAL] Knowledge base has ~a facts\n" 
          (length knowledge-base))
  (visualize-knowledge knowledge-base)
  
  ;; Demonstrate queries
  (printf "\n--- QUERY EXAMPLES ---\n")
  (query-knowledge '(Socrates is-a _))
  (query-knowledge '(_ has-property Mortal))
  (query-knowledge '(Socrates _ _))
  
  ;; Forward chaining inference
  (define expanded-kb (forward-chain knowledge-base 3))
  (printf "\n[EXPANDED] Knowledge base now has ~a facts\n"
          (length expanded-kb))
  (visualize-knowledge expanded-kb)
  
  ;; Backward chaining proof
  (define goal (triple 'Socrates 'has-property 'Mortal))
  (define proof (prove-goal goal expanded-kb))
  
  (when proof
    (printf "\n[PROOF] Successfully proved: Socrates is Mortal\n")
    (printf "[PROOF] Chain of reasoning:\n")
    (for ([f proof])
      (define t (fact-triple f))
      (printf "  - ~a ~a ~a\n"
              (triple-subject t)
              (triple-predicate t)
              (triple-object t))))
  
  (printf "\n╔══════════════════════════════════════════╗\n")
  (printf "║  COGNITIVE SYNERGY ANALYSIS              ║\n")
  (printf "╚══════════════════════════════════════════╝\n\n")
  
  (printf "Synergies Demonstrated:\n\n")
  (printf "1. S-EXPRESSIONS as KNOWLEDGE\n")
  (printf "   - Natural representation for symbolic knowledge\n")
  (printf "   - Code and data unified (homoiconicity)\n\n")
  
  (printf "2. PATTERN MATCHING for REASONING\n")
  (printf "   - Queries expressed as patterns\n")
  (printf "   - Inference rules as pattern transformations\n\n")
  
  (printf "3. FORWARD + BACKWARD CHAINING\n")
  (printf "   - Forward: Derive all consequences\n")
  (printf "   - Backward: Prove specific goals\n")
  (printf "   - Synergy: Complete reasoning system\n\n")
  
  (printf "4. TRUTH VALUES for UNCERTAINTY\n")
  (printf "   - Strength + confidence encoding\n")
  (printf "   - Propagated through inference\n")
  (printf "   - Enables reasoning under uncertainty\n\n"))

;; ============================================================================
;; MAIN
;; ============================================================================

(module+ main
  (demonstrate-knowledge-reasoning))
