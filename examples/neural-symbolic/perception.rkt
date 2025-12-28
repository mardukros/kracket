#lang racket

;; Perception Module for Neural-Symbolic Worker
;; Processes sensory input and converts to internal representations

(require racket/match)

(provide perceive
         parse-sensory-input
         extract-features)

;; Main perception function
(define (perceive input)
  (match input
    ;; Text-based perception
    [(list 'text text-data)
     (perceive-text text-data)]
    
    ;; Symbolic perception
    [(list 'symbolic symbolic-data)
     (perceive-symbolic symbolic-data)]
    
    ;; Structured data perception
    [(list 'structured data)
     (perceive-structured data)]
    
    ;; Default: pass through as symbolic
    [_ (list 'concept input)]))

;; Perceive text input
(define (perceive-text text)
  (define words (string-split text))
  (for/list ([word words])
    (list 'concept (string->symbol word))))

;; Perceive symbolic input
(define (perceive-symbolic data)
  (match data
    [(list pred subj obj)
     (list 'relation pred subj obj)]
    [concept
     (list 'concept concept)]))

;; Perceive structured data
(define (perceive-structured data)
  (cond
    [(hash? data)
     (for/list ([(k v) (in-hash data)])
       (list 'property k v))]
    [(list? data)
     (map perceive data)]
    [else (list 'concept data)]))

;; Parse sensory input into cognitive representation
(define (parse-sensory-input input)
  (define perceived (perceive input))
  (list 'percept
        'raw input
        'processed perceived
        'timestamp (current-inexact-milliseconds)))

;; Extract features from perceived data
(define (extract-features percept)
  (match percept
    [(list 'percept args ...)
     (define processed (assoc 'processed (cdr percept)))
     (if processed
         (list 'features
               'count (if (list? (cadr processed)) 
                         (length (cadr processed)) 
                         1)
               'type (if (list? (cadr processed))
                        (car (cadr processed))
                        'unknown))
         '(features empty))]
    [_ '(features empty)]))

;; Module test
(module+ test
  (require rackunit)
  
  (test-case "text perception"
    (define result (perceive '(text "hello world")))
    (check-equal? (length result) 2)
    (check-equal? (car (car result)) 'concept))
  
  (test-case "symbolic perception"
    (define result (perceive '(symbolic (isa dog animal))))
    (check-equal? (car result) 'relation))
  
  (test-case "sensory parsing"
    (define result (parse-sensory-input '(text "test")))
    (check-equal? (car result) 'percept))
  
  (test-case "feature extraction"
    (define percept (parse-sensory-input '(symbolic (concept test))))
    (define features (extract-features percept))
    (check-equal? (car features) 'features)))
