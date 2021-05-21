;; Scheme implementation of Drug Design.
;; by Areeba Khan

;; USAGE:
;; 1. first make changes to default values. 
;; 2. run the following in the terminal
;;  ./scheme
;;  (load "dd_serial.scm")
;;  (main)
;;
;; OUTPUT will be:
;; the maximal value 
;; followed by the list of corresponding ligands.

;; modules and previously created files
(use-modules (rnrs) (ice-9 futures))
(load "dd_helper.scm")
(load "dd_ds.scm")
(load "dd_algorithm.scm")
(load "tasks.scm")

; global variables
(define DEFAULT_max_ligand 5)
(define DEFAULT_nligands 20) ; 6. 94 seconds
(define DEFUALT_protein "the cat in the hat wore the hat to the cat hat party")

; make changes to default values here: (uncomment them)
;(define DEFAULT_max_ligand INT)
;(define DEFAULT_nligands INT)
;(define DEFUALT_protein STRING)


(define main 
  (lambda () 
    ;(do-reduce(do-map (generate-tasks '() DEFAULT_nligands DEFAULT_max_ligand) (string-split DEFUALT_protein) '())) ))
    (do-map 
      '(("u" "a") ("k" "c" "s" "f") ("g" "x" "v" "j" "h") ("s" "x" "a") ("r") ("a" "j" "b" "b" "o") ("a" "c" "e" "g") ("u" "b") ("p") ("a" "f" "z" "w" "c") ("o" "w") ("w" "h" "m") ("u") ("u") ("d" "i" "l" "x" "s") ("k" "d") ("y") ("a") ("e" "a") ("h" "u" "m" "s" "k"))
    (string-split DEFUALT_protein) '()) ))

;;maximum  3 inputs, first two are integers and 3rd is a string. Or no input at all. use cond to get input == 1;2;3 or else display usage error

;; MAP AND REDUCE FUNC---------------
(define do-map
  (lambda (ligands protein pairs) ;; takes in list of ligands, protein strand, and vector<Pair> pairs     
    ;; now to loop through all the ligands. 
    (do-map-helper (cdr ligands) protein (get-first-vector (car ligands) protein)) ))

(define get-first-vector
  (lambda (ligand protein)  
    (vector-pair (Pair (score ligand protein) (string-join ligand)))))

(define do-map-helper 
  (lambda (ligands protein pairs)
    (cond ((null? ligands) pairs)
          (else 
            (do-map-helper (cdr ligands) protein (push-back pairs 
              (Pair (get-score (car ligands) protein) (string-join (car ligands))) ))))))

(define (get-score ligand protein)
  (let ((f (future (score ligand protein)))) (touch f)))


(define do-reduce
  (lambda (vector)
    ;(display "-----\nVector: ") ; print statements for debugging. 
    ;(display vector)
    ;(display "\n -----\nReduce")
    (do-reduce-helper vector (list (caar vector) '()))))
; caar 
(define do-reduce-helper
(lambda (vector lst)
    (cond ((null? vector) lst) 
          ((< (caar vector) (car lst)) 
              (do-reduce-helper (cdr vector) lst)) ;skip iteration
          ((= (caar vector) (car lst)) 
              (do-reduce-helper (cdr vector) 
                  (list (car lst) (append (car(cdr lst)) (list(cdr (car vector)))))))
          (else ; greater than, then recall do-reduce 
              (do-reduce vector)))))

;; helper functions below 
(define get-ligand ; generates random ligand string
  (lambda (max-ligand) (get-ligand-help (get-random-int max-ligand))))


(define generate-tasks 
  (lambda (queue nligands max-ligand)
    (cond ((= nligands 0) '())
          (else (push 
                  (generate-tasks queue (- nligands 1) max-ligand) 
                  (get-ligand max-ligand))))))

(define score 
  (lambda (str1 str2)  ;; str1, str2 are list of strings: ("s" "t" "r")
    (cond ((or (null? str1) (null? str2)) 0)
          ((equal? (car str1) (car str2)) (+ 1 (score (cdr str1) (cdr str2))))
          (else (max (score str1 (cdr str2)) (score (cdr str1) str2)  )))))
