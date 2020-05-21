#lang racket

;(provide (all-defined-out) )

(define s "hello")
(define x 3)
(define y (+ x 2)) ; + is a function, call

(define cube1
  (lambda (x)
    (* x (* x x))))

(define cube2
  (lambda (x)
    (* x x x)))

(define (cube3 x)
  (* x x x))

(define (pow1 x y) ;x to the yth power (y must be non-negative)
  (if (= y 0)
      1
      (* x (pow1 x (- y 1)))))

(define pow2
  (lambda (x)
    (lambda (y)
      (pow1 x y))))
;null - empty list
;cons - make list longer for the one element
;car - head
;cdr - tail
;null? - check for empty
;list e1 .. en - make liest of few elements



;sum all numbers in list
(define (suml l)
  (if (null? l)
  0
  (+ (car l) (suml (cdr l)))))

;append
(define (my-append xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (my-append (cdr xs) ys))))

;map
(define (my-map f xs)
  (if (null? xs)
      null
      (cons (f (car xs))
            (my-map f (cdr xs)))))
;cond
(define (sum4 xs)
  (cond [(null? xs) 0]
        [(number? (car xs)) (+ (car xs) (sum4 (cdr xs)))]
        [(list? (car xs) (+ (sum4 (car xs)) (sum4 (cdr xs))))]
        [#t (sum4 (cdr xs))]))
        
(define xs (list 4 5 6))
(define ys (list (list 4 (list 5 0)) 6 7 (list 8) 9 2 3 (list 0 1)))
; sum up the list values of undefined depth
(define (sum1 xs)
  (if (null? xs)
      0
      (if (number? (car xs))
          (+ (car xs) (sum1 (cdr xs)))
          (+ (sum1 (car xs)) (sum1 (cdr xs))))))

; version 2 of sum up - skip non-number values of list
(define (sum2 xs)
  (if (null? xs)
      0
      (if (number? (car xs))
          (+ (car xs) (sum2 (cdr xs)))
          (if (list? (car xs))
              (+ (sum2 (car xs)) (sum2 (cdr xs)))
              (sum2 (cdr xs))))))


(define (max-of-list xs)
  (cond [(null? xs) (error "max-of-list given empty list")]
        [(null? (cdr xs)) (car xs)]
        [#t (let ([tlans (max-of-list (cdr xs))])
              (if (> tlans (car xs))
                  tlans
                  (car xs)))]))

;Delayed evaluation - put expression in a function to be used later
(define (factorial-normal x)
  (if (= x 0)
      1
      (* x (factorial-normal (- x 1)))))

(define (my-if x y z)
  (if x (y) (z)))

(define (fact n)
  (my-if (= n 0)
         (lambda () 1)
         (lambda () (* n (fact (- n 1))))))

; e -> evaluate expression
; (lambda () e) -> thunk, delayed execution - put expression inside annonymous function
; (e) -> evaluate thunk - call the delayed expression


(define (my-mult x y-thunk)
  (cond [(= x 0) 0]
        [(= x 1) (y-thunk)]
        [#t (+ (y-thunk) (my-mult (- x 1) y-thunk))]))

;(my-mult 0 (lambda () (slow-add 3 4)))
;(my-mult 10 (let ([x (slow-add 3 4)]) (lambda () x)))


;Delay and Force
(define (my-delay th)
  (mcons #f th))

(define (my-force p)
  (if (mcar p)
      (mcdr p)
      (begin (set-mcar! p #t)
             (set-mcdr! p ((mcdr p)))
             (mcdr p))))

;(my-mult x (let ([p (my-delay (lambda () (slow-add 3 4)))])
;            (lambda () (my-force p))))

;powers-of-two

; Stream
(define (number-until stream tester)
  (letrec ([f (lambda (stream ans)
                (let ([pr (stream)])
                  (if (tester (car pr))
                      ans
                      (f (cdr pr) (+ ans 1))))
                  )])
    (f stream 1)))

;(number-until powers-of-two (lambda (x) (= x 16)))

; Defining Stream
; 1 1 1 1 1 ...
(define ones (lambda () (cons 1 ones)))
;(define ones-really-bad (cons 1 ones-really-bad))
(define ones-bad (lambda () (cons ones-bad)))

; 1 2 3 4 5
(define (f x) (cons x (lambda () (f (+ x 1)))))
(define nats1 (lambda () (f 1)))

(define nats
  (letrec ([f (lambda (x) (cons x (lambda () (f (+ x 1)))))])
           (lambda () (f 1))))

; 2 4 8 16
(define powers-of-two
  (letrec ([f (lambda (x) (cons x (lambda () (f (* x 2)))))])
    (lambda () (f 2))))

; Memoization - if the function doesn't rpoduce any side effects - it's useful to keep cache on repeated calculations - i.e. store precomputed results
(define (fibonacci1 x)
  (if (or (= x 1) (= x 2))
      1
      (+ (fibonacci1 (- x 1))
         (fibonacci1 (- x 2)))))

; More efficient variant using memoization. Memo is the cache in this case.
; "assoc" - library function that checks if the car of value is in the list
(define fibonacci3
  (letrec ([memo null] ; list of pairs -> (arg . result) : argument and calculated fib value
           [f (lambda (x)
                (let ([ans (assoc x memo)])
                  (if ans
                      (cdr ans)
                      (let ([new-ans (if (or (= x 1) (= x 2))
                                         1
                                         (+ (f (- x 1))
                                            (f (- x 2))))])
                        (begin
                          (set! memo (cons (cons x new-ans ) memo))
                          new-ans)))))])
    f))

