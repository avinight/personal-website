With load-time address binding, programs can be loaded to different memory addresses when they start, but cannot be relocated later. Why not?
- The relocation table used during program loading is discarded once the program is ready to execute, so it would be impossible to find the addresses that need to be translated once the program starts running. 
- **Once the program starts executing, addresses can be copied into other locations and may not even be identifiable as addresses, so the original relocation table can't be used to translate all addresses.**
	- This happens whenever a C program stores the address of a variable into another variable (e.g. `int \*x = &y;`). In A2, we store flags in the lowest 3 bits of a message queue pointer, so these may not be identifiable as addresses anymore.
- It would take too long to relocate all the addresses again after the program starts executing.

Why would we want to change the memory locations used by a process (e.g., why would we want to relocate addresses after a program starts executing)?
- **To reduce fragmentation of the physical memory space.**
- To ensure that different physical memory locations receive the same amount of use (i.e., wear leveling).
- **To allow a process to be removed from memory (swapped out) and brought back (swapped in) to different memory locations.**
- **To allow the process to dynamically increase the amount of memory that it is using (move into a larger memory area)**.

The C library heap uses dynamic partitioning. The heap can suffer from **both types of** fragmentation. Compaction **cannot** be used to deal with fragmentation in the heap.

Suppose we have a dynamic partitioning scheme, and the current state of memory is shown in the diagram above. Each square in the diagram represents 4096 bytes (4KB) of memory. Blue squares are allocated, white squares are free.

What is the largest process (in bytes) that can be placed in memory without performing any compaction? **20480**

What is the largest process (in bytes) that can be placed in memory after performing compaction? **45056**

Suppose the previous allocation placed the 24K process in memory, and we now need to place a 8K process in memory. 

Where is the process placed using the first-fit algorithm? **In the first 2 blocks of the 5-block hole.**

Where is the process placed using the best-fit algorithm? **In the 2-block hole (allocates the entire hole)**