#lang racket

;; Neural-Symbolic Worker Demonstration
;; Shows the complete cognitive cycle with neural-symbolic integration

(require "neural-worker.rkt"
         "perception.rkt"
         "reasoning.rkt"
         "action.rkt"
         "learning.rkt")

(printf "=== Neural-Symbolic Worker Demo ===\n\n")

;; Create a neural-symbolic worker
(printf "1. Creating neural-symbolic worker...\n")
(define worker (make-neural-worker))
(printf "   ✓ Worker created\n\n")

;; Add some initial knowledge (symbolic)
(printf "2. Adding symbolic knowledge to atomspace...\n")
(worker-add-knowledge worker '(concept dog))
(worker-add-knowledge worker '(concept cat))
(worker-add-knowledge worker '(concept animal))
(worker-add-knowledge worker '(relation isa dog animal))
(worker-add-knowledge worker '(relation isa cat animal))
(printf "   ✓ Added concepts: dog, cat, animal\n")
(printf "   ✓ Added relations: dog->animal, cat->animal\n\n")

;; Demonstrate perception
(printf "3. Perception: Processing sensory input...\n")
(define sensory-input '(text "The dog barks"))
(define percept (parse-sensory-input sensory-input))
(printf "   Input: ~a\n" sensory-input)
(printf "   Percept: ~a\n\n" percept)

;; Query the knowledge base
(printf "4. Querying knowledge base...\n")
(define concepts (worker-process worker '(query (all-concepts))))
(printf "   All concepts: ~a\n\n" concepts)

;; Demonstrate hybrid reasoning
(printf "5. Hybrid Reasoning: Symbolic + Neural...\n")
(define inference-result (worker-process worker '(infer (isa dog animal))))
(printf "   Query: (isa dog animal)\n")
(printf "   Result: ~a\n\n" inference-result)

;; Demonstrate neural embeddings
(printf "6. Neural Embeddings: Vector representations...\n")
(define dog-embedding (worker-get-embedding worker 'dog))
(printf "   Dog embedding (first 5 dims): ~a\n" 
        (vector-take dog-embedding 5))

(define cat-embedding (worker-get-embedding worker 'cat))
(printf "   Cat embedding (first 5 dims): ~a\n\n" 
        (vector-take cat-embedding 5))

;; Demonstrate similarity computation
(printf "7. Neural Similarity: Finding similar concepts...\n")
(define similarities (worker-process worker '(similar dog)))
(printf "   Similar to 'dog': ~a\n\n" similarities)

;; Demonstrate learning
(printf "8. Learning: Adding new knowledge and adjusting embeddings...\n")
(worker-learn worker '(concept bird) '(flies))
(define bird-embedding (worker-get-embedding worker 'bird))
(printf "   ✓ Learned concept 'bird'\n")
(printf "   Bird embedding (first 5 dims): ~a\n\n" 
        (vector-take bird-embedding 5))

;; Complete cognitive cycle demonstration
(printf "9. Complete Cognitive Cycle:\n")
(printf "   Perception -> Reasoning -> Action -> Learning\n\n")

(define (cognitive-cycle input)
  ;; Perception
  (printf "   [Perception] Processing: ~a\n" input)
  (define perceived (perceive input))
  
  ;; Reasoning
  (printf "   [Reasoning] Applying inference...\n")
  (define kb '((concept dog) (concept animal) (isa dog animal)))
  (define reasoning-result (hybrid-reason kb perceived))
  
  ;; Action
  (printf "   [Action] Generating action...\n")
  (define action-result (act reasoning-result))
  
  ;; Learning
  (printf "   [Learning] Updating knowledge...\n")
  (define learning-result (learn '() `(positive-example ,perceived) 'good))
  
  (printf "\n   Cycle complete!\n")
  (printf "   - Perceived: ~a\n" perceived)
  (define symbolic-pair (assoc 'symbolic reasoning-result))
  (printf "   - Reasoned: ~a\n" (if symbolic-pair (cadr symbolic-pair) 'none))
  (printf "   - Action: ~a\n" action-result)
  (printf "   - Learned: ~a\n\n" learning-result))

(cognitive-cycle '(symbolic (concept robot)))

;; Display worker statistics
(printf "10. Worker Statistics:\n")
(define stats (neural-worker-stats worker))
(printf "   - Processed: ~a operations\n" (hash-ref stats 'processed))
(printf "   - Learned: ~a examples\n" (hash-ref stats 'learned))
(printf "   - Synergies: ~a hybrid inferences\n\n" (hash-ref stats 'synergies))

;; Demonstrate meta-cognitive capabilities
(printf "11. Meta-Cognitive Reflection:\n")
(define performance-history '(0.6 0.7 0.75 0.8))
(define meta-learning-result (meta-learn '() performance-history))
(printf "   Performance history: ~a\n" performance-history)
(printf "   Meta-learning: ~a\n" meta-learning-result)
(define strategy-pair (assoc 'strategy meta-learning-result))
(printf "   Strategy: ~a\n\n" (if strategy-pair (cadr strategy-pair) 'unknown))

(printf "=== Demo Complete ===\n")
(printf "\nKey Insights:\n")
(printf "• Symbolic reasoning provides interpretable knowledge structures\n")
(printf "• Neural embeddings enable similarity-based reasoning\n")
(printf "• Hybrid approach combines strengths of both paradigms\n")
(printf "• Cognitive synergy emerges from component integration\n")
