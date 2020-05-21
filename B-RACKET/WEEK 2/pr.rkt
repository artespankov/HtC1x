#lang racket
(provide (all-defined-out))

; Datatype without Structs
; helper function where first argument is a symbol
(define (Const i) (list 'Const i))
(define (Negate e) (list 'Negate e))
(define (Add e1 e2) (list 'Add e1 e2))
(define (Multiply e1 e2) (list 'Multiply e1 e2))

; tester helper function
(define (Const? x) (eq? (car x) 'Const))
(define (Negate? x) (eq? (car x) 'Negate))
(define (Add? x) (eq? (car x) 'Add))
(define (Multiply? x) (eq? (car x) 'Multiply))

; helper functions that get pieces for one of exp
(define (Const-int e) (car (cdr e)))
(define (Negate-e e) (car (cdr e)))
(define (Add-e1 e) (car (cdr e)))
(define (Add-e2 e) (car (cdr (cdr e))))
(define (Multiply-e1 e) (car (cdr e)))
(define (Multiply-e2 e) (car (cdr (cdr e))))

; recursive structure without patterns
(define (eval-exp- e)
  (cond [(Const? e) e] ; returning exp, not number
        [(Negate? e) (Const (- (Const-int (eval-exp- (Negate-e e)))))]
        [(Add? e) (let ([v1 (Const-int (eval-exp- (Add-e1 e)))]
                        [v2 (Const-int (eval-exp- (Add-e2 e)))])
                    (Const (+ v1 v2)))]
        [(Multiply? e) (let ([v1 (Const-int (eval-exp- (Multiply-e1 e)))]
                             [v2 (Const-int (eval-exp- (Multiply-e2 e)))])
                         (Const (* v1 v2)))]
        [#t (error "eval-exp expected an exp")]))

; Datatype with Structs
; LANGUAGE IMPLEMENTATION
(struct const (int) #:transparent)             ; int should hold a number
(struct negate (e1) #:transparent)             ; e1 should hold an expression
(struct add (e1 e2) #:transparent)             ; e1 e2 should hold expressions
(struct multiply (e1 e2) #:transparent)        ; e1 e2 should hold expressions
(struct bool (b) #:transparent)                ; b should hol #t or #f
(struct eq-num (e1 e2) #:transparent)          ; e1 e2 should hold expressions
(struct if-then-else (e1 e2 e3) #:transparent) ; e1 e2 e3 should hold expressions
; a value in this language is a legal const or bool
;-----


(define (eval-exp e)
  (cond [(const? e) e]
        [(negate? e) (const (- (const-int (eval-exp (negate-e1 e)))))]
        [(add? e) (let ([v1 (const-int (eval-exp (add-e1 e)))]
                        [v2 (const-int (eval-exp (add-e2 e)))])
                        (const (+ v1 v2)))]
        [(multiply? e) (let ([v1 (const-int (eval-exp (multiply-e1 e)))]
                             [v2 (const-int (eval-exp (multiply-e2 e)))])
                         (const (* v1 v2)))]
        [#t (error "eval-exp expected an exp")]))

(define a-test (eval-exp (multiply (negate (add (const 2) (const 2)))
                                   (const 7))))
; ----
; legal AST (eval-exp test1)
(define test1 (multiply (negate (add (const 2)
                                     (const 2)))
                        (const 7)))
; illegal AST (eval-exp test2)
(define test2 (multiply (negate (add (const 2)
                                     (const 2)))
                        (if-then-else (bool #f)
                                      (const 7)
                                      (bool #t))))
; not a test case              
(define non-test (multiply (negate (add (const #t)
                                        (const 2)))
                           (const 7)))

; should be called through eval-exp)
;(define (eval-under-env e env)
;  (cond ...  ; case fopr each kind of expression
;   ))

; Higher-order functions (closures)
(struct closure (env fun) #:transparent)

; Macros - function that takes expression as input and produces expression
(define (andalso e1 e2)
  (if-then-else e1 e2 (bool #f)))

(define (double e)
  (multiply e (const 2)))

(define (list-product es) ; take in a Racket list
  (if (null? es)
      (const 1)
      (multiply (car es) (list-product (cdr es)))))


(define test (andalso (eq-num (double (const 4))
                              (list-product (list (const 2)
                                                  (const 2)
                                                  (const 1)
                                                  (const 2))))
  (bool #t)))




