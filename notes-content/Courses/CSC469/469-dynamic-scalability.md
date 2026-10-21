---
tags:
  - course/csc469
  - computer-science
---
Dynamic memory allocation
- Highly parallel applications are common
- Dynamic memory allocation is ubiquitous
- Traditional allocators do not sclae
	- Single global hep with central locking
	- Correct, but allocation and deallocation are serialized
- Naively concurrent allocators are insufficient
	- Early (circa 2000) designs improved concurrency
	- Still suffered from poor scalability under contention

Parallel allocator requirements
- Speed
	- As fast as a serial allocator on a single-processor system
		- i.e. not slower in single-threaded cases
- Scalability
	- Performance scales well with number of processors
		- Ideally near-linear under low contention
- False sharing avoidance
	- Does not introduce false sharing of cache lines
- Low fragmentation
	- Keep meory overhead low, i.e. minimize OS Allocated Mem / Application Allocated Mem
	- How does fragmentation affect performance?
		- Paging faults and swapping are the biggest issue
		- Overhead of memory management with a memory allocator
		- Spatial locality - we no longer have it to increase the speed of our applications

False sharing
- Multiple processors access different variables on the same cache line
	- No logical sharing, but cache coherence treats it as shared
- Program induced
	- Caused by how the program lays out or uses data
	- E.g. per-CPU counters stored contiguously without padding
- Allocator induced
	- Caused by memory allocation decisions, not program logic
	- Active: malloc() returns objects on the same cache line to different threads
		- Cache line bouncing
	- Passive: free() causes future allocations to create false sharing
		- T2 frees T1 memory and is now on its free list, future allocations will cause false sharing
Blowup
- A specific form of fragmentation
	- Amount of memory a parallel allocator uses compared to an ideal serial allocator
		- max allocated / max allocated by ideal uniprocessor allocator
- Can be unbounded
	- May grow linearly with the number of CPUs or threads
	- Becomes worse
- Root cause
	- Freed memory is not reused effectively across threads
	- Memory remains stranded in the "wrong" heap

Allocator Designs
- Single single heap
	- 1 locked free list
	- Low fragmentation, quite fast
	- Lock contention -> poor scaling
	- Active false sharing
	- Advantages
		- Simple design
		- Low fragmentation
		- Good single-thread performance
	- Disadvantages
		- Severe contention
		- poor scalability
		- Active alse sharing
- Concurrent single heap
	- One global heap
	- Separate locked free list per size class
	- Intended advantage
		- Reduces contention <= only when everybody is using every size uniformly
	- Reality most allocations are only a few commons sizes
		- Contention for hot free lists
	- Still relies on locking or atomic operations
	- Active false sharing
	- Limited scalability

- Multiple-heaps
	- Use multiple logical heaps to reduce contention
	- Heap assignment strategies:
		- One heap per thread
		- RR assignment
		- Hash or mapping function from thread to heap
- Pure private heaps
	- Threads allocate from private heap; freed block goes to the freeing threa's heap
	- Low contention and fast allocation
	- Unbounded memory usage under producer-consumer workloads (blowup)
	- Passive false sharing

Solution: Move memory back to the original owner
- Private heaps with ownership
	- Each processor has a private heap
		- Threads allocate from the heap of the processor they are running on
	- Freed blocks return to the allocating processor's heap
		- Preserves ownership to avoid unbounded blowup
	- Low contention and fast local allocation
	- Problems
		- O(P) blowup for P processors without memory redistribtuion
			- Freed memory may not be reusable where future allocations occur
		- Some implementations actively induce false sharing
			- This is a side effect of trying to reduce fragmentation

- Private heaps with thresholds
	- Inspired by Vee and Hsu (DYNIX)
		- A scalable and efficient storage allocator on shared-memory multiprocessors
	- Use threshold to trigger memory transfer between heaps
	- Organize memory in a hierarchy or per-processor heaps and shared heaps
	- Benefits
		- Efficient and scalable
		- O(1) bounded blowup
	- Remaining issue
		- Can still passively induce false sharing

# Hoard - scalable memory allocator
---
### Key Arguments and Contributions
- **Scalable Performance**: Unlike traditional serial allocators that act as a bottleneck, Hoard's performance scales linearly with the number of processors.
- **Bounding "Blowup"**: Many concurrent allocators suffer from "blowup"—a dramatic increase in memory consumption in producer-consumer patterns. Hoard is the first to provably bound this consumption to a constant factor (O(1)).
- **Avoiding False Sharing**: The allocator prevents processors from inadvertently sharing data on the same cache line, which otherwise degrades performance due to cache coherence traffic.
- **Efficiency and Low Synchronization**: By using **superblocks** and only accessing the global heap when a local heap's usage drops below an "emptiness threshold," Hoard maintains nearly zero synchronization costs in the common case.
- **Experimental Validation**: On 14 processors, Hoard improved program performance over the standard Solaris allocator by up to a factor of 60 and outperformed the next best tested allocator by a factor of 18.

Fast, Avoid false sharing, scalable, 


Hoard's design
- per-processor heap plus a single global heap
- Threads are associated with a processor heap
	- A thread allocates from the heap of the processor it was originally assigned to
		- Even if the OS later schedules the thread on a different processor
- Heaps are divided into page-aligned superblocks
	- All superblocks have the same size (multiple of the system page size)
- Each superblock is divided into fixed-size blocks
	- All blocks within a superblock have the same size
	- Different superblocks may use different block sizes
- Block sizes are grouped into size classes
	- Size classes grow geometrically (power-of-b apart, where b>1)
	- There is a minimum block size (e.g. 16 bytes)
- This design bounds internal fragmentation

Block Sizes
- Block sizes are grouped into size classes that grows geometrically
- The size of each class S_i is determined by three parameters:
	- b: constant factor; must be greater than 1
	- B: the minimum block size, usually 16 bytes
	- A: the minimum alignment requirement, typically also 16 bytes$$ S_i = align\_to(B \times b^i, A) $$
- This design bounds internal fragmentation to approximately b-1
- E.g. suppose b = 1.1 then worse-case internal fragmentation is 10%


Bounding blowup
- Each heap owns a set of superblocks
	- Assigned from global heap on allocation
	- A heap onlly allocates from superblocks it owns
- When no memory available in any superblock on a thread's heap
	- Obtain a superblock from the global heap, if available
	- If not (global heap empty too), create a new superblock request from OS, and add to thread's heap
- Empty superblocks are not returned to the OS
	- Retained locally and reused
	- May be moved to the global heap under the right conditions
- Superblocks may be returned to the global heap
	- Happens when a sufficient fraction of blocks are free
- Return condition
	- If a heap is more than f-empty and
	- It has more than K superblocks' worth of free space,
	- Then one superblock that is at least f-empty is transferred to the global heap
	- Example: 3 superblocks, f = 1/4, k=1, Do not return
		- Slack space neededd
- Bounds wasted space on each heap to $K \cdot S + f \cdot A_i$
	- S: Size of superblock 
	- A_i: Memory allocated to heap i

Modern allocators use mmap rather than sbrk, reducing the number of mmaps that happen
- Superblocks returned to global heap when f, the empty fraction, of blocks are not in use
	- If heap is more than f-empty, and has more than K superblocks worth of free space, transfer a superblock that is at least f-empty to global heap
	- If heap not more than f-empty, or has K or fewer superblocks worth of free space, no superblocks get moved to global heap
	- Reduces false sharing
		- Only superblocks that are at least f-empty are released
		- Actively shared superblocks are unlikely to migrate between heaps
- Intuitively, these conditions maintain invariants about the proportion of wasted space on each heap. (Hoarding)
- Gives O(1) blowup
- Also limits the amount of false sharing since released superblocks are guaranteed to be at least f-empty
- Fullness groups: <- most important part of the paper
	- Bins of superblocks with the same "fullness" range
	- LIFO order -> reuse superblocks that is already in memory
	- Also likely to use a block already in cache -> maintains good locality
	- Maintains good locality


