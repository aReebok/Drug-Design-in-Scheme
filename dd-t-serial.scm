;; Scheme implementation of Drug Design.
;; this is the TIMED version
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
(use-modules (rnrs))
(load "dd_helper.scm")
(load "dd_ds.scm")
(load "dd_algorithm.scm")
(load "time.scm")
(load "tasks.scm")


; global variables
(define DEFAULT_max_ligand 5)
(define DEFAULT_nligands 20)
(define DEFUALT_protein "the cat in the hat wore the hat to the cat hat party")

(define main 
  (lambda () 
    (set! startT (localtime (current-time)))
    (display "Start time: ")
    (display (strftime "%c" startT))
    (display "\n")
    (display "Program output: ")
    (display (do-reduce (do-map 
                 task5 (string-split DEFUALT_protein) '()))) 
            (display "\n ")
    (set! endT (localtime (current-time)))
    (display "Start time: ")
    (display (strftime "%c" endT))
    (display "\n")
    ;; ----------------------------------------
    (display (time endT startT)) 
    (display "\n----end of S program-----\n")
    (display "\n-----------------------\n")

    ))

;;maximum  3 inputs, first two are integers and 3rd is a string. Or no input at all. use cond to get input == 1;2;3 or else display usage error

;; MAP AND REDUCE FUNC---------------
(define do-map
  (lambda (ligands protein pairs) ;; takes in list of ligands, protein strand, and vector<Pair> pairs     
    ;; now to loop through all the ligands. 
    (do-map-helper (cdr ligands) protein (get-first-vector (car ligands) protein))))

(define get-first-vector
  (lambda (ligand protein)  
    (vector-pair (Pair (score ligand protein) (string-join ligand)))))

(define do-map-helper 
  (lambda (ligands protein pairs)
    (cond ((null? ligands) pairs)
          (else 
    (do-map-helper (cdr ligands) protein (push-back pairs (Pair (score (car ligands) protein) (string-join (car ligands))))) ))))

(define do-reduce
  (lambda (vector)
    (do-reduce-helper vector (list (caar vector) '()))))

 
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
          (else (max (score str1 (cdr str2)) (score (cdr str1) str2))))))