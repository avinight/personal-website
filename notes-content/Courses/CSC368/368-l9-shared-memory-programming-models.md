---
tags:
  - course/csc368
  - computer-science
---
Most OpenMP programs only use these 19 items

| OMP                                                                    | Concepts                                                                                              |
| ---------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `#pragma omp parallel`                                                 | Parallel region, teams of threads, structured block, interleaved execution across threads             |
| int omp_get_thread_num()<br>int omp_get_num_threads()                  | Create threads with a parallel region and split up the work using the number of threads and thread ID |
| double omp_get_wtime()                                                 | Speedup and Amdahl's law                                                                              |
| setenv OMP_NUM_THREADS N                                               | Internal control variables. Setting the default number of threads with an environment variable        |
| `#pragma omp barrier`<br>`#pragma omp critical`                        | Synchronization and race conditions                                                                   |
| `#pragma omp for`<br>`#pragma omp parallel for`                        | Work-sharing, parallel loops, loop carried dependencies                                               |
| `reduction(op:list)`                                                   | Reductions of values across a team of threads                                                         |
| `schedule(dynamic [.chunk])`<br>`schedule (static [.chunk])`           | Loop schedules, loop overheads, and load balance                                                      |
| private(list), firstprivate(list), shared(list)                        | Data environment                                                                                      |
| nowait                                                                 | Disabling implied barriers on workshare constructs                                                    |
| `#pragma omp single`                                                   | Workshare with a single thread                                                                        |
| `#pragma omp task` and `#pragma omp section`<br>`#pragma omp taskwait` | Tasks including the data environment for tasks                                                        |

