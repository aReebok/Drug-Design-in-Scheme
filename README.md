# Drug Design in Scheme

### Usage

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
### Time Analysis

Analysis: see more data at: https://docs.google.com/spreadsheets/d/1vTTcX9EjVpMA67DmTOZLshke-N7cI5u1lpVs5BJ3vOI/edit#gid=0

Observations:

    1. sequential program in scheme is way slower than C++ sequential to begin with. Althought scheme is a bit easier to 
    write after a lot of practice compared to C++, it's clear that scheme is much slower because it's very hard to optimize
    scheme code. There is definetly a better way to write this scheme code to be more scheme-y. However, instead of making 
    that a change (which would interest me maybe in the summer), I wanted to focus more on the timing of the parallel process
    instead. 

    2. I noticed that I was able to acquire data such that every parallel time entry for Drug Design algorithm was faster than
    the time entires of the sequential version. This was reassuring that there is some parallel threads at work here. I have
    split up the TASKS list in 2 lists, and these two lists are being mapped on two different threads. I've only parallelized 
    a portion of the code (the mapping part of assigning score to each ligand in the list), so the reduce and some other small
    operations are being done sequentially. 

    3. I've noticed that although parallel results seem to be consistently faster, it is the case that it's usually not that
    much faster: less than 30%, rather than the 50% i expected from using two threads (see the Thoughts section below).

    4. Althought this is the case, I noticed that as we increase the number of ligands, the difference between the runtime for
    parallel vs serial is more aparent. 

    5. After working on dd_pFutures.scm, where I use the Futures/touch documentation to implement parallelism in the scheme file, 
    I noted that when it finally compiled, it was slower than the sequential scheme file. So I ended up not timing it.

Thoughts:

    While writing my observation, I was thinking about why some parallel timings are very close to the serial timeing. 

    1. There is some additional recursion in the parallel program that helps with splitting the list of tasks in two,
    and then putting them back together.

    2. when a list of tasks is split in two and the parallel processing begins in the program, if LIST1 has ligands that
    are larger in length than LIST2, then it would take longer for list1 to be completed. The parallel program will then
    just have to wait for LIST1 to be completed even though LIST2 has already been completed (so this is not efficient). 

    Another thing I was confused about: if i'm using two threads for the most extensive part of the code, shouldn't the
    runtime of the code be halved? Especially since a bulk of the runtime is in the mapping, which I've parallelized using
    two threads?

        The main issue to the question that I am posing here is that I am assuming that the ENTIRE program is being running
        in parallel on two threads simultaniously. This would mean that the program runtime should be halved. However, it's 
        clear that I've only parallelized the mapping portion of the code and, although that is a bulk of the code, it's 
        not 100% of it. 

        Additionally, there is a small, thought not insignificant amount of code that has been added to the parallel version 
        of drug design. This is the split helper function that recursively splits a list in two. With increasing sizes of list
        this computation may get heavy. Since this function is not present in the sequential version of the code, it adds more
        to the run time of the parallel version, making the run time of the parallel tests be a lot closer to the sequential.

    Using the Amdahl's Law and the data recorded, I would like to calculate the percent of code that was parallelized:  

    >> AMDAHL's LAW (calculations in spreadsheet)
    OVERALL_SPEEDUP = old_excecution_time / new_excecution_time =  ( 1 / ((1 - P) + (P/N)) )
                    = ( 1 / ((1 - P) + (P/N)) )                      P is percent of code parallelized
  ((1 - P) + (P/N)) = 1 / OVERALL_SPEEDUP                           N is the number of processes/threads
         N - NP + P = N / OVERALL_SPEEDUP
          P (1 - N) = (N / OVERALL_SPEEDUP) - N
                  P = ((N / OVERALL_SPEEDUP) - N) / (1 - N)

    Using the AMDAHL's LAW, and our data collection, I would like to see what the law says is the percent of code that we 
    have parallized (solving for variable P). See the spreadsheet for the calculations. 

    The resulting value: 23.01% of the code was parallelized.

    This seems off because the bulk of the code has been parallelized. The most intensive part of the code is the mapping 
    portion that can have worse case (O) = n^3, where n is the lenght of the ligand. It doesn't make sense here to see that
    only 23% of the code was parallelized. 
    
    Some cause of this may be, as previously mentioned in point 2 of this section, is that the uneven lists are waiting for
    each other to be computed and thus, the program waits for both the processes to finish their work before combining their
    output. This makes a lot of sense, though its still concerning that it's happening so often as to reduce the percent so
    low from what I expected. A way of fixing this would be that instead of randomizing the lenght of each ligand, I keep it
    constant. I think it would be very interesting to test that out and see if it makes any changes to the runtime. 


Presetation slides: https://docs.google.com/presentation/d/1vmdLWFapsJwq-ldD9Xce0x__LMxxhwMqkxUoGVayCu4/edit?usp=sharing
redoing time analysis with time.scm implemented below --- 

    **** IMPORTANT NOTE: 
    A lot of the timeigs were recorded in a spreadsheet linked in line 1:
    https://docs.google.com/spreadsheets/d/1vTTcX9EjVpMA67DmTOZLshke-N7cI5u1lpVs5BJ3vOI/edit#gid=0
    Some trials are not listed here because it was easier to record them and
    it looks more presetable on the spreadsheet! 
