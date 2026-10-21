---
tags:
  - course/csc469
  - computer-science
---
Multiprocessor Synchronization
- True parallelism
	- Code executes simultaneously on multiple CPUs
	- Threads may access shared memory at the same time
- Uniprocessor techniques no longer work
	- Disabling context switches does not help. Why?
		- Other CPUs continue executing
		- Disabling interrupts only affects the local CPU
- Locking
	- Grouping multiple operations requires mutual exclusion across CPUs
	- How do we implement this efficiently?

What do we need to implement locks?
- Hardware support
	- CPUs provide atomic instructions
		- E.g. test and set (TAS), compare and swap (CAS), fetch and add (FAA)
		- These guarantee atomicity of individual memory operations
- However, atomicity alone is not sufficient for correctness
	- Visibility: when writes by one CPU become visible to others
	- Ordering: the order in which memory operations may be observed
	- Memory consistency model
		- Defines when writes become visible and how operations may be reordered
		- We will assume sequential consistency for this lecture
			- i.e. all CPUs observe memory operations as if they occurred in a single global order

Contention and Scalability
- Locking serializes execution of critical sections
	- Only one CPU can execute the critical section at a time
	- Limits ability to use multiple processors
	- Amdahl's Law?
- Contention
	- Occurs when a thread attempts to acquire a lock that is already held
	- Results in waiting or spinning instead of useful work
- Scalability
	- Ability to increase throughput as the number of CPUs increases

Impact of Contention on Scalability
- Frequently contended locks limit scalability
- More CPUs can mean more waiting, not more progress
- Granularity trade-off
	- i.e. how much work or data is protected by a single lock
	- Coarse-grained locks
		- large critical sections -> high contention
		- Fine-grained locks
			- Reduce contention but increase complexity and lock overhead

Spinlocks
- Simple idea
- Loop testing lock variable until it becomes available
	- Good if you have nothing else to do 
	- Or if expected wait is short
		- e.g. less than 2 context switches
	- Or if you aren't allowed to block
		- Like in interrupt handler
- Today's focus will be on spinlocks

Cost of Locking
- Test-and-set (TAS) lock operates on memory location atomically
- Causes repeated cache line invalidations and coherence traffic
	- Requires for atomic instructions
	- Slows down other memory operations on all CPUs

Building a better spinlock
- IDEA: spin in cache, access memory only when lock is likely to be available
	- Known as test-and-test-and-set (TTAS)

Spinning with backoff
- IDEA: if lock is held, wait awhile before probing again
	- Best performance uses exponential backoff
	- Can cause fairness problems.
		- Why? because the first one out will have to wait the longest?

Ticket locks
- Resolve fairness issues (FIFO order)
- Lock consists of two counters (`next_ticket, now_serving`)
- Reduces number of atomic operations
- Upon lock release, waiters will cause a burst of coherence traffic on `now_serving`

Queuing Locks
- IDEA: Each thread spins on a different memory location
	- Reduces cache coherence traffic, reduces memory contention
	- Lock variable points to end of list of threads that want the lock
		- Current lock holder is at the head of the list
		- Lock acquire adds node for thread to tail of list, behind the predecessor.
		- Lock release unblocks only the next node in list (the successor)
	- Guarantees FIFO ordering

MCS locks