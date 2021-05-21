; in this file i explore the timing documentation on Guile scheme:
; https://www.gnu.org/software/guile/manual/html_node/Time.html

(define startT )
(define endT )

; (set! localt1  (localtime (current-time)))
; (set! localt2 (localtime (current-time)))
; (display "start time1: ")
; (display (strftime "%c" localt1))
; (display "\n")

; (display "start time2: ")
; (display (strftime "%c" localt2))
; (display "\n")

(define time-diff 
    (lambda (vector2 vector1) 
        (cons (-(vector-ref vector2 2) (vector-ref vector2 2))
            (cons (- (vector-ref vector2 1) (vector-ref vector1 1))
                (cons (- (vector-ref vector2 0) (vector-ref vector1 0)) '())) )))

(define return-time 
    (lambda (lst sum) 
        (cond ((= (length lst) 3) (return-time (cdr lst) (+ (* (car lst) 3600) sum) ))
                ( (= (length lst) 2) (return-time (cdr lst) (+ (* (car lst) 60) sum)) )
                (else 
                    (+ (car lst) sum)
                    )
        )
    ))

(define time 
    (lambda (l2 l1) 
        (display "runtime: in seconds\n")
        (display ">>       ")
        (return-time (time-diff l2 l1) 0) ))

; (define subtract (lambda (l2 l1) 
;     ; (display "start time1: ")
;     ; (display l1)
;     ; (display "\n")

;     ; (display "start time2: ")
;     ; (display l2)
;     ; (display "\n")

;     ; 10

; ))
