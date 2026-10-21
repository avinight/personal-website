
the problem with signal comms is there are limited number of signal numbers

link processes to a single memory location

shared memory attached = shmat

child writes to parent, it will see it immediately
shared memory detach

this goes to memory mapped region <- shared memory region

#### Parallel programs

if one client updates the cache, then other clients will see that updated results


problem: inefficient for webservers -> waste memory 
we want to share most things

page table creates address space implementation
 IPC 
how do we avoid the overhead?

threads: execution state in same address space 
- independent state of execution
- single control flow through a program

- implicit sharing and simpler programming model

we don't need to touch PTBR with context switching with threads
if one process crashes then all the threads crash


How is threading different from fork?
- interprocess, threads share same address space
- Difference is that processes are more expensive

guard region detect and prevents stack overflow from happening
1. memory protection: `mprotect()` perms for a region of memory -> traps into kernel. process can do smth to deal with situation. kill that thread (not supported in all OS)
2. guard region filled up with some bits (only a detection)

thread 3 checks its guard region for modified bits. It can choose to kill the process or terminate the thread.

<span style="background:#b1ffff">guard region doesn't protect against arbitrary memory corruption</span>
<span style="background:#b1ffff">why not have ECCs?</span>

why is fork() more expensive if only 1 register is changed during context switching? (solved)

remember difference between kernel thread and kernel level thread.
- kernel thread runs entirely in the OS kernel.
- kernel level threads are threads handled by the kernel.

Problems: 
kernel level won't be scheduled
user level threads may be scheduled 

If one of the user level threads blocked, then all the user level threads will be blocked. -> blocking happens at the OS level, not the user level.

To solve these problems -> we need comms 
- Scheduler activation -> notify library runtime
	- OS can tell the user library 
- don't worry about this for A1

pthreads is just an API not an implementation

Thread switching
- CRT0 will call exit() for main
- thread exit() will change the thread 

when we start a thread, there are no timer interrupts in A1, so all threads run to completion

for sorting
creating too many threads -> ran out of virtual mem space for all the threads
we went over process quota