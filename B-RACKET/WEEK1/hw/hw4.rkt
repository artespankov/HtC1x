
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

; Problem 1
(define (sequence low high stride)
  (cond [(>= high (+ low stride))
         (cons low (sequence (+ low stride) high stride))]
        [#t (cons high null)]))

; Problem 2
(define (string-append-map xs suffix)
  (map (lambda (s) (string-append s suffix)) xs))

; Problem 3
(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (car (list-tail xs
                       (remainder n (length xs))))]))

; Problem 4
(define ones (lambda () (cons 1 ones)))

(define (stream-for-n-steps s n)
  (if (<= n 0)
      null
      (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))))

; Problem 5
(define (funny-number-stream)
  (define (f x)
    (cons (if (= 0 (remainder x 5)) (- x) x) (lambda () (f (+ x 1)))))
  (f 1))

; Problem 6
(define (dan-then-dog)
  (define (f x)
    (cons x (lambda () (f (if (eq? x "dan.jpg") "dog.jpg" "dan.jpg")))))
  (f "dan.jpg"))

; Problem 7
(define (stream-add-zero s)
  (define (f x) (cons
     (cons 0 (car (x)))
     (lambda () (f (cdr (x))))))
  (lambda () (f s)))

; Problem 8
(define (cycle-lists xs ys)
  (define (f n) (cons (cons (list-nth-mod xs n)
                            (list-nth-mod ys n))
                      (lambda () (f (+ n 1)))))
  (lambda () (f 0)))

; Problem 9
(define (vector-assoc v vec)
  (cond [(null? vec) #f]
        [(eq? (car vec) v) v]
        [#t (vector-assoc v (cons (cdr v)))]))

; Problem 10
(define (cached-assoc xs n)
  (define (f x)
    ((let  ))
  (lambda (v) (assoc v xs)))
  