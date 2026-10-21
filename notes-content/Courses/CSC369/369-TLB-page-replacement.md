Tags:

---

Paging limitations - time
Memory reference overhead (time)
- 2 memory reads (references) per address lookup
- First read page table, then actual memory
- Hierarchical page tables make it worse
- One read per level of page table
- Solution: use a hardware cache of lookups
Translation Lookaside Buffer (TLB)
- Small, fully-associative hardware cache of recently used translations
- Can only cache a small fraction of page table entries in a page table
- Part of the Memory Management Unit (MMU)

TLBs exploit locality
Principle of Locality (locality of reference)
- Processes only use a handful of pages at a time
- Only need those pages to be “mapped”
- 16-64 entry TLB, so 16-64 pages can be mapped (64-192K)
Hit rates are very important
- Typically > 99% of translations are hits
But we still need to deal with misses
- Called a TLB miss or TLB fault

Managing TLBs
- Who places translations into the TLB (loads the TLB)?
	- Hardware-loaded (Memory Management Unit, e.g. Intel Pentium)
		- Knows where page tables are in main memory (PTBR)
		- OS maintains tables in memory, HW accesses them directly
		- Tables must be in HW-defined format (inflexible)
	- Software-loaded TLB (OS, e.g. MIPS R2000)
		- Tables can be in any format convenient for OS (flexible)
		- TLB faults to OS, OS finds appropriate PTE, loads it in TLB
		- Must be fast (but still 20-200 cycles)
	- CPU ISA has instructions for manipulating TLB
		- Add entry, read entry, invalidate entry, invalidate all entries (flush
- OS ensures that TLB and page tables are consistent
	- When it changes the protection bits of a PTE, it needs to update the copy of the PTE in the TLB (if one exists)
	- Typically, just invalidate the entry
- Reload TLB on a process context switch so we don't perform the wrong translation
	- Invalidate all entries
	- This makes context switch expensive 
		- because the next process will resume execution with a bunch of TLB misses at the beginning
		- (this is why we use spinlocks)
- When the TLB misses and a new PTE must be loaded, a cached PTE likely needs to be evicted
	- Choosing PTE to evict is called the TLB replacement policy
	- Implemented in hardware (for hardware loaded TLB), often simple

Cr3 = ptbr in intel core i7 architecture


## Demand paging
- load pages into memory as they are referenced
Paged virtual memory
- Pages can be moved between memory and disk
	- This method of memory management is called demand paging
- OS uses main memory as page cache of all data allocated in the system
	- Initially, pages are allocated from memory
	- When memory fills up, allocating a page in memory requires some other page to be evicted from memory
	- Evicted pages go to disk (where? the swap file)
	- The movement of pages between memory and disk is done by the OS
		- Transparent to the application
- OS must keep track of use of each physical frame
	- Coremap data structure
		- which virtual page of which process is allocated to each frame
		- if evict, we can find PTE in that processes page table to mark it as evicted

Page Faults
- What happens when a process accesses a page that has been evicted?
1. When it evicts a page, the OS sets the PTE as invalid and stores the location of the page in the swap file in the PTE
2. When a process accesses the page, the invalid PTE will cause a trap (page fault)
3. The trap will run the OS page fault handler
4. Handler uses the invalid PTE to locate page in swap file
5. Reads page into a physical frame, updates PTE to point to it
6. Resume process
- But where does it put it? Have to evict something else
	- Expensive, handling page fault may require 2 disk accesses
	- OS keeps some free pages so that allocations do not always cause evictions

Locality
- All paging schemes depend on locality
	- Processes reference pages in localized patterns
- Temporal locality
	- Locations referenced recently likely to be referenced again.
	- Example:
		- For loop counter
```C
for (int i = 0; i < 1000; i++) {
	…
}
```
- Spatial locality
	- Locations near recently referenced locations are likely to be referenced soon.
	- Example:
		- Sequential array access
```C
for (int i = 0; i < 1000; i++) {
	array[i] = i;
}
```

Although cost of paging is high, if it’s infrequent enough, it’s acceptable
- Processes usually exhibit both kinds of locality during their execution, making paging possible
- All caching strategies depend on locality to be effective

Policy decisions
- Page tables, MMU, TLB, etc., are mechanisms
	- They make virtual memory possible
- Now, we’ll look at policies for virtual memory management:
- Fetch Policy – **when** to fetch a page
	- Demand paging vs. Prepaging
- Placement Policy – **where** to put the page
	- Are some physical pages preferable to others?
- Replacement Policy – **what** page to evict to make room?
	- Lots and lots of possible algorithms!

Demand paging (OS)
- Demand paging from the OS perspective:
	- Pages are evicted to disk when memory is full
	- Pages loaded from disk when referenced again
	- References to evicted pages cause a TLB miss
		- PTE was invalid, causes fault
	- OS allocates a page frame, reads page from disk
	- When I/O completes, the OS fills in PTE, marks it valid, resume process, retry faulting instruction
- Dirty vs. clean pages
	- Actually, only dirty pages (modified) need to be written to disk
	- Clean pages do not – but need to know where on disk to read them from again

Demand paging (Process)
- Demand paging is also used when a process first starts up
- When a process is created, it has:
	- A brand new page table with all valid bits off
	- No pages in memory
- When the process starts executing
	- Instructions fault on code and data pages
	- Faulting stops when all necessary code and data pages are in memory
	- Only code and data needed by a process needs to be loaded
	- This, of course, changes over time…

Costs of demand paging
- Timing: Disk read is initiated when the process needs the page
- Request size: Process can only page fault on one page at a time, disk sees single page-sized read
- What alternative do we have?

Prepaging (Prefetching)
- Predict future page use at time of current fault
	- On what should we base the prediction? What if it’s wrong?

Placement policy
- In paging systems, memory management hardware can translate any virtual-to-physical mapping equally well
- Why would we prefer some mappings over others?
	- NUMA (non-uniform memory access) multiprocessors
		- any processor can access entire memory, but local memory is faster
	- Cache performance
		- Choose physical pages to minimize cache conflicts
	- Topics covered in more detail in [[CSC469]]
- Placement policy will have smaller effect than fetch and replacement policies if memory is limited.

Page replacement policy
- Determines how a victim is chosen for replacement
- Goal of replacement algorithm
- To reduce the fault rate by selecting the best victim page to remove
- Replacement algorithms are evaluated on a reference string by counting the number of page faults
- Ideal: The best page to evict is the one never used again
- Practical: Pick the page closest to “never” is the next best thing
- Evicting the page that won’t be used for the longest period of time minimizes the number of page faults
- Proved by Belady, 1966

Belady's algorithm
- Known as the optimal page replacement algorithm because it has the lowest fault rate for any page reference string (aka OPT or MIN)
	- Idea: Replace the page that will not be used for the longest period of time
	- Problem: Have to know the future perfectly
- Why is Belady’s useful then? Use it as a yardstick
	- Compare implementations of page replacement algorithms with the optimal to gauge room for improvement
	- If optimal is not much better, then algorithm is pretty good
	- If optimal is much better, then algorithm could use some work
		- Random replacement is often the lower bound

First-in first-out
- FIFO is an obvious algorithm and simple to implement
	- Maintain a list of pages in order in which they were paged in
	- On replacement, evict the one brought in longest time ago
- Why might this be good?
	- Maybe the one brought in the longest ago is not being used
- Why might this be bad?
	- No information about a page except its age in memory
- FIFO suffers from “Belady’s Anomaly”
	- The fault rate might actually increase when the algorithm is given more memory
		- Very bad!


<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---