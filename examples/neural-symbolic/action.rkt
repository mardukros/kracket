#lang racket

;; Action Module for Neural-Symbolic Worker
;; Generates actions based on reasoning results

(require racket/match)

(provide act
         generate-action
         execute-action)

;; Main action function
(define (act reasoning-result)
  (match reasoning-result
    [(list 'hybrid-inference args ...)
     (generate-action-from-inference reasoning-result)]
    
    [(list 'inferred conclusions)
     (generate-action-from-conclusion conclusions)]
    
    [_ (list 'action 'observe 'no-action-needed)]))

;; Generate action from inference result
(define (generate-action-from-inference inference)
  (define confidence (assoc 'combined-confidence inference))
  
  (cond
    [(and confidence (> (cadr confidence) 0.8))
     (list 'action 'assert 'high-confidence)]
    [(and confidence (> (cadr confidence) 0.5))
     (list 'action 'explore 'medium-confidence)]
    [else
     (list 'action 'learn 'low-confidence)]))

;; Generate action from conclusion
(define (generate-action-from-conclusion conclusions)
  (if (list? conclusions)
      (list 'action 'apply (car conclusions))
      (list 'action 'report conclusions)))

;; General action generator
(define (generate-action context intent)
  (list 'action
        'intent intent
        'context context
        'timestamp (current-inexact-milliseconds)))

;; Execute an action (for demonstration)
(define (execute-action action)
  (match action
    [(list 'action type args ...)
     (list 'executed type 'with-args args 'success #t)]
    [_ (list 'executed 'unknown 'success #f)]))

;; Module test
(module+ test
  (require rackunit)
  
  (test-case "action from inference"
    (define inference '(hybrid-inference 
                       symbolic (inferred test)
                       neural-confidence 0.9
                       combined-confidence 0.85))
    (define action (act inference))
    (check-equal? (car action) 'action)
    (check-equal? (cadr action) 'assert))
  
  (test-case "action generation"
    (define action (generate-action 'test-context 'learn))
    (check-equal? (car action) 'action))
  
  (test-case "action execution"
    (define action '(action assert high-confidence))
    (define result (execute-action action))
    (check-equal? (car result) 'executed)))
