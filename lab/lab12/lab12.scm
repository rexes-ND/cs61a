(define (if-program condition if-true if-false)
  (list 'if condition if-true if-false)
)

(define (pow-expr n p) 
  (
    if (= p 0) '1
    `(* ,(pow-expr n (- p 1)) ,n)
  )
)

(define (cddr s) (cdr (cdr s)))

(define (cadr s) (car (cdr s)))

(define (caddr s) (car (cddr s)))

(define (swap expr)
  (
    let ((op (car expr))
        (first (car (cdr expr)))
        (second (caddr expr))
        (rest (cdr (cddr expr))))
    (
      let (
        (first_val (eval first))
        (second_val (eval second))
      )
      (
        if (> second_val first_val)
        (append (list op second first) rest)
        (append (list op first second) rest)
      )
    )  
  )
)
