(define run-f
    (lambda () 
        (display "-------------------------------------\n")
        (display "----------------PROGRAM--------------\n")
        (display "-------------------------------------\n")
        (load "dd-t-parallel.scm")
        (main)
        (load "dd-t-serial.scm")
        (main) ))

(define run
    (lambda () 
        (run-f)
        (run-f)
        (run-f)))