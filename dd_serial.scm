;; Scheme implementation of Drug Design.
;; by Areeba Khan

;; modules and previously created files
(use-modules (rnrs))
(load "dd_helper.scm")
(load "dd_ds.scm")
(load "dd_algorithm.scm")

; global variables
(define DEFAULT_max_ligand 4)
(define DEFAULT_nligands 20)
(define DEFUALT_protein "the cat in the hat wore the hat to the cat hat party")


(define main 
  (lambda () 
    (do-reduce (do-map (generate-tasks '() DEFAULT_nligands DEFAULT_max_ligand) (string-split DEFUALT_protein) '())) ))

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
  (lambda (l p ps)
    (cond ((null? l) ps)
          (else 
            (do-map-helper (cdr l) p (push-back ps (Pair (score (car l) p) (string-join (car l)))))))))

; (define do_reduce 
; take list pairs => smaller list of pairs with highest scores -- 
; (3 ("abcdefg" "xyz3"))
; (4 ("that one" "xyzxyz"))
; ; )
; (list (car '(1 (1 2 3 4 5))) (append (car(cdr '(1 (1 2 3 4 5)))) (list 200)))


(define do-reduce
  (lambda (vector)
    (display "-----\nVector: ")
    (display vector)
    (display "\n -----\nReduce")
    (do-reduce-helper vector (list (car (car vector)) '()))))
; caar 
(define do-reduce-helper
(lambda (vector lst)
    (cond ((null? vector) lst) 
          ((< (car (car vector)) (car lst)) 
              (do-reduce-helper (cdr vector) lst)) ;skip iteration
          ((= (car (car vector)) (car lst)) 
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

