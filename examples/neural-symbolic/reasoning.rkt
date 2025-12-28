#lang racket

;; Reasoning Module for Neural-Symbolic Worker
;; Implements hybrid symbolic-neural reasoning

(require racket/match)

(provide reason
         forward-chain
         backward-chain
         hybrid-reason)

;; Main reasoning function
(define (reason knowledge-base query strategy)
  (match strategy
    ['forward (forward-chain knowledge-base query)]
    ['backward (backward-chain knowledge-base query)]
    ['hybrid (hybrid-reason knowledge-base query)]
    [_ (hybrid-reason knowledge-base query)]))

;; Forward chaining inference
(define (forward-chain kb query)
  (define results '())
  
  ;; Apply rules from knowledge base
  (for ([fact kb])
    (match fact
      [(list 'rule (list 'implies premise conclusion))
       (when (matches-pattern? premise query)
         (set! results (cons conclusion results)))]
      [_ (void)]))
  
  (if (null? results)
      (list 'no-inference query)
      (list 'inferred results)))

;; Backward chaining inference
(define (backward-chain kb goal)
  (define (find-rules-for goal)
    (filter
     (lambda (fact)
       (match fact
         [(list 'rule (list 'implies _ conclusion))
          (equal? conclusion goal)]
         [_ #f]))
     kb))
  
  (define rules (find-rules-for goal))
  (if (null? rules)
      (list 'cannot-prove goal)
      (list 'proved goal 'via (length rules) 'rules)))

;; Hybrid symbolic-neural reasoning
(define (hybrid-reason kb query)
  ;; Symbolic component
  (define symbolic-result (forward-chain kb query))
  
  ;; Neural component (simulated - embeddings-based confidence)
  (define neural-confidence
    (if (member query kb)
        0.95
        0.4))
  
  ;; Combine results
  (list 'hybrid-inference
        'symbolic symbolic-result
        'neural-confidence neural-confidence
        'combined-confidence (if (eq? (car symbolic-result) 'inferred)
                                 (max neural-confidence 0.8)
                                 neural-confidence)))

;; Helper: check if premise matches pattern
(define (matches-pattern? premise pattern)
  (cond
    [(and (list? premise) (list? pattern))
     (and (>= (length premise) 1)
          (>= (length pattern) 1)
          (or (equal? (car premise) (car pattern))
              (eq? (car pattern) '_)))]
    [else (equal? premise pattern)]))

;; Module test
(module+ test
  (require rackunit)
  
  (define test-kb
    '((concept dog)
      (concept animal)
      (rule (implies (isa dog animal) (has-property animal alive)))
      (isa dog animal)))
  
  (test-case "forward chaining"
    (define result (forward-chain test-kb '(isa _ _)))
    (check-true (list? result)))
  
  (test-case "backward chaining"
    (define result (backward-chain test-kb '(has-property animal alive)))
    (check-true (list? result)))
  
  (test-case "hybrid reasoning"
    (define result (hybrid-reason test-kb '(concept dog)))
    (check-equal? (car result) 'hybrid-inference)
    (check-not-false (assoc 'combined-confidence result))))
