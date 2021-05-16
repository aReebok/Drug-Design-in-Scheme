;; ligand generator helper function 
;;


;; helper helper functions: --------------------------------------------
;; -----------------------: --------------------------------------------
(define random-letter  ;; helper functions
  ; list of alphabets to randomly choose from.
  (let* ((chars '("a" "b" "c" "d" "e" "f" "g" "h" "i" 
                  "j" "k" "l" "m" "n" "o" "p" "q" "r"
                  "s" "t" "u" "v" "w" "x" "y" "z"))
        (len (length chars)))  ; calculates the length of the char list 
    (lambda () 
      (list-ref chars (random len))))) ; picking random char at (random len)



(define get-random-int ; generates random integer given range
  (lambda (range) (+ (random range) 1))) 

(define get-ligand-help
  (lambda (ligand-len) 
    (cond ((<= ligand-len 0) '())
          (else (cons (random-letter) (get-ligand-help (- ligand-len 1)))))))

;; (use-modules (rnrs))
(define (string-join strings) ; returns a single string of strings in list
  (fold-right string-append "" strings)) ;; helper func


(define (pair-to-list string) ; return a list of strings given a string of chars
  (cond ((null? string) '())   ;; helper helper func
        (else (cons (make-string 1 (car string))(pair-to-list (cdr string))))))

(define (string-split string) ; calls helper function to split string into individual characters. 
  (pair-to-list (string->list string))) ;; helper func
;; -----------------------: --------------------------------------------
;; score function:
;;


(define (split lst at)
  (define (iter n l i)
    (if (or (null? l) (= i at))
      (cons (reverse n) l)
      (iter (cons (car l) n) (cdr l) (+ i 1))
    )
  )
  (iter '() lst 0)
)  