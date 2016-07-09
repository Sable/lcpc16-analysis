LCPC16 Submission Experiments
=============================

This is a repository containing all the artifacts and code versions we used to
perform the evaluation section for the LCPC16 submission. In addition to the
experiments mentioned in the paper, it contains experiments that were not
discussed either because they turned out to be only tangentially relevant to
our work, or we did not have the space in the paper. In addition, in this
README and others in sub-directories, we explain in more details some of our
choices in the experiment design. By making all of of the experiments publicly
available as well as explaining in more details our experiment design, we aim
to make our research more reproducible and easier to build upon for future work
by our own or other researchers.

The repository follows the Wu Wei conventions and is compatible with its
commandline tools (https://github.com/Sable/wu-wei-benchmarking-toolkit/).

Each benchmark has multiple implementations that were either created by hand or
automatically using the Mc2Mc tool (https://github.com/Sable/Mc2Mc). Each
benchmark has its own README that explains the results we obtained for the
different versions and the interpretation we made of the different results.

Analysis of the performance on the different versions of Matlab
===============================

Code versions:

    - matlab         : original MATLAB code
    - matlab-plus    : vectorized MATLAB code with checks
    - matlab-plus-no : vectorized MATLAB code with no checks

Compilers:

    - MATLAB R2013a
    - MATLAB R2015b

Benchmarks:

    10 benchmarks (including spmv)

Testing

    - MATLAB R2013a with JIT on  -> figure_Linux-with-JIT.pdf
    - MATLAB R2013a with JIT off -> figure_Linux-without-JIT.pdf
    - MATLAB R2015b with JIT on  -> figure_Linux-MATLAB-2015.pdf

Findings

    1. When the JIT is turned off, 9 of 10 benchmarks have speedup.
       Especially, the blackscholes and Monte Carlo simuations.
    2. When the JIT is turned on, the speedup of R2013a and R2015b
       is obvious, but the R2015b has fewer speedup due the improvement
       of the JIT.  The same reason applies to the MC and pagerank.
    3. Why is the performance of lgdr improved in R2015b?
       After I carefully checked the code and I found none loops can
be vectorized.
       I think we should remove this benchmark from the list. It seems
the JIT fails
       in R2015b.  Anyway, it is irrelevant to our topics.


R2015 release note

    MATLAB Execution Engine: Run programs faster with redesigned
architecture (Performance section)
    Link: http://www.mathworks.com/help/matlab/release-notes.html

    "The new MATLAB execution engine includes performance improvements
to function calls, object-oriented operations, and many other MATLAB
operations. These performance improvements result in significantly
faster execution of many MATLAB programs with an average speed-up of
40% among 76 performance-sensitive applications from users. Of these
tested applications, 13 ran at least twice as fast and only 1 slowed
down by more than 10%. The new execution engine uses just-in-time
compilation of all MATLAB code which makes performance more uniform
and predictable. The new engine offers improved quality and provides a
platform for future performance optimizations and language
enhancements."

Analysis of the performance on Octave
================


The current Octave version is 4.0 which doesn't support the JIT.  The
benchmark 'pagerank' is tested with the medium-size input.  To my
surprise, the performance of Octave is much worse in loops compared
with MATLAB.  With vectorization, Octave can achieve impressive
speedup (65x~73x).  The reason that the 'pagerank' doesn't have much
speedup is because of MATLAB's JITs.  With the competitive JITs, the
advantage of the vectorization for loops is decreased sometimes even
worse.

|implementation | environment | mean      |
|-------------- | ----------- | --------- |
|matlab         | matlab-vm   | 1.6423s   |
|matlab-vector  | matlab-vm   | 1.5448s   |
|matlab-plus    | matlab-vm   | 1.5272s   |
|matlab         | octave      | 728.1882s |
|matlab-vector  | octave      | 11.1293s  |
|matlab-plus    | octave      | 9.8707s   |


Performance summary:

In MATLAB: (baseline matlab)

    | matlab | vector | plus   |
    | 1.0000 | 1.0631 | 1.0754 |


In Octave (baseline matlab)

    | matlab | vector | plus    |
    | 1.0000 | 65.4298| 73.7727 |
