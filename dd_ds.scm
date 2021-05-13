;; This file contains the different strucuts/datastructures in dd_serial.cpp
;;
;; queue data structure methods
;;

(define push
  (lambda (queue item)
    (cond ((null? queue) (cons item '())) 
          (else (append queue (cons item '()))))))

(define peek
  (lambda (queue) 
    (if (null? queue) '() (car queue))))

(define pop ; deletes first in list element (does not return this element)
  (lambda (queue)
    (if (null? queue) '() (cdr queue)))) ; returns the rest of the list


;;-------------------------------------------------------
;; vector<Pair> data structure methods
;;
(define vector-pair ; creates a new vector<pair>. 
;; a LIST of Pairs
  (lambda (pair) (cons pair '())))

(define vector-key
  (lambda (vector index)
    (cond ((= index 0) (get-key vector))
          (else 
            (vector-val (cdr vector) (- index 1))))))

(define vector-val
  (lambda (vector index)
    (cond ((= index 0) (get-val vector))
          (else 
            (vector-val (cdr vector) (- index 1))))))

(define vector-size
  (lambda (vector)
    (cond ((null? vector) 0)
          (else (+ 1 (vector-size (cdr vector)))))))

;(push-back (push-back (vector-pair(Pair 1 "hi")) (Pair 10 "hello world")) (Pair 12 "hehe im sad"))
(define push-back
  (lambda (vector pair)
    (append vector (cons pair '()))))


;;-------------------------------------------------------
;; Pair --
  ; Pair(int k, const string &v) {key = k;  val = v;}
(define Pair
  (lambda(key val) (cons key val)))

(define get-key (lambda (pair) (car pair)))
(define get-val (lambda (pair) (car (cdr pair))))

(define compare ;;compare the keys of two pairs...
  (lambda (p1 p2)
    (if (> (get-key p1) (get-key p2)) #t #f)))