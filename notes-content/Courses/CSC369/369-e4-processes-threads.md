---
tags:
  - course/csc369
  - computer-science
---
Why does mergesort_fork_noshm fail to sort the array?
- The program runs out of memory due to excessive process creation.
- The program exceeds the system's process quota, causing some forks to fail.
- It is not possible to run mergesort algorithm in parallel.
- The child processes time out before completing their sorting tasks.
- **The child processes cannot share the sorted results with the parent process.**

Why is mergesort_fork_shm slower than mergesort_seq?
- **The overhead of creating and managing multiple processes outweighs the benefits of parallelism.**
- **Shared memory requires coordination between processes, adding overhead.**
- The operating system imposes limitations on shared memory performance to minimize performance impact to other processes.
- Running multiple processes results in more overhead in context switching.
- **The array size is too small to benefit from parallelism, making the overhead dominate.**

Why does mergesort_fork_shm fail for larger input arrays?
- The shared memory region is too small to handle the data for larger input arrays.
- **The program exceeds the system's maximum process limit due to excessive forking.**
- Recursive forking causes a stack overflow as the recursion depth increases with larger input sizes.
- **The operating system runs out of memory because each process requires its own memory space.**
- **The overhead of managing a large number of processes can overload the system.**

Which is faster, mergesort_fork_shm or mergesort_fork_noshm?
- Similar performance
- Correctness aside, the performance of the two different implementations should have similar performance due to the need to create additional processes. The overhead is sharing memory is negligible.

Which is faster, mergesort_fork_shm or mergesort_pthreads?
- Similar performance
- In Linux, processes and threads have similar performance due to various software and hardware optimizations for processes, e.g., optimized shared memory, reduced context switching overhead, copy-on-write (optimization for fork), etc.