# Drug Design in Scheme

###Usage
The main files are:
    1. dd-t-serial.scm      this holds the code that computes the drug design algorithm sequentially.
                            in ln 39, we can change the task it's computing.

    2. dd-t-parallel.scm    this holds the code that computes the drug design algorithm in 2 parallel
                            threads. in ln 45-46, we can change the task it's computing. 

    3. time-run.scm         this holds the code to acquire three different timed trials of running 
                            the same tasks on both serial and parallel scheme files.

    4. tasks.scm            this holds the tasks that can be run in both parallel and in serial file 
                            to make sure that we're running the same thing during the tests.

  These are the files that I run in the demo videos.
  Here is HOW TO RUN the program.
  ---------------------------------------------------------------------------------------------
    1. First in WSL/ubuntu terminal, in the current file directory, start scheme.
        user@stolaf:DrugDesign/proj$  ./scheme
    2. in scheme interpreter, enter these two lines of code:
        scheme@(guile-user)> (load "time-run.scm")
        scheme@(guile-user)> (run)

    (OPTIONAL STEPS in changing the tasks...)
        NOTE: by default, dd-t-parallel and serial run task4 
            where n_ligands = 50, max_ligands = 4.

    3. then look at tasks.scm -- (OPTIONAL) pick which task you would like to test.
        a. taskN, where N is the max length of ligands. 
        b. (OPTIONAL) in the scheme interpreter, generate your own list of tasks by:
                scheme@(guile-user)>  (generate-tasks '() n_ligands max_ligands)
            where the n_ligands in the number of ligands, i.e. 120
            and max_ligands is the maximum lenght of these ligands.
            Paste these into tasks.scm 
    4. after picking the tasks, change dd-t-parallel.scm in lines 45-46 to use taskN.
        additionally change dd-t-serial.scm in line 39 to use taskN. 
    5. Run step 2.
  ---------------------------------------------------------------------------------------------
    Output of the (run) from previous steps.
        >> this "time-run.scm" program starts by running the "dd-t-parallel.scm", followed by running 
        the "dd-t-serial.scm", three times. 
        It gives the start time of the program, the program output, the end time of the program, followed
        by the runtime of the program in seconds and an indication that P or S program has finished. 
  ---------------------------------------------------------------------------------------------
  The rest of the files: 
  
    1. time.scm             this holds the code for timing the "dd-t-*.scm" and the "dd_pFutures.scm"
                            it subtracts start time from end time and returns the end time in seconds. 

    2. time_analysis.txt    this holds only SOME of my collected data: see the spreadsheet link attached. 
                            Additiaonlly, I also record my observations, thoughts about the result, and any
                            additional information that I came across during data collecting.

    3. dd_algorithm.scm     this holds the max function that is used in score. it was also going to software
                            the sorting function, though I came around to write the code without it.

    4. dd_ds.scm            this holds data structure functions for a queue and a vector<pair>

    5. dd_helper.scm        this file holds the helper functions

    6. dd_parallel.scm      this is the parallel scheme version of DrugDesign (untimed)
                            Also, this is the library I used: 
                            https://www.gnu.org/software/guile/manual/html_node/Parallel-Forms.html

    7. dd_serial.scm        this is the sequential scheme version of DrugDesign (untimed)

    8. dd_pFutures.scm      this is my attempt to using the Futures/touch library to paralleize the scheme code. 
                            when running it, it seems to be slower than both the serial and the parallel file. 
                            althought it took a very long time to finally get it to compile and run. 
                            https://www.gnu.org/software/guile/manual/html_node/Futures.html

    9. dd_serial2.scm       this is a backup copy for file "dd_serial.scm"

    10. project_log.txt     this is the file that holds the logged hours throght the project: I wasn't able
                            to access the log online, so I started writing it down here.

    11. dd_serial.cpp       this is the provided sequential Drug Design in C++ exemplar by Macalester webpage:
                            http://selkie.macalester.edu/csinparallel/modules/DrugDesignInParallel/build/html/
