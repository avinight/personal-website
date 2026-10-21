Tags:

---

Least Recently Used (LRU)
- Uses reference information to make good replacement decision
- Idea: can’t predict future, but can make a guess based on past experience
	- On replacement, evict the page that has not been used for the longest time in the past (Belady’s: future)
- When does LRU do well?
	- Program with high temporal locality
- When does LRU do poorly?
	- Program with low temporal locality
	- E.g., repeated sequential array access larger than available memory

Implementing exact LRU
- Option 1:
	- Time stamp every reference
	- Evict page with oldest time stamp
	- Need to make PTE large enough to hold meaningful time stamp
		- May double size of page tables and TLBs
	- Need to examine every page on eviction to find one with oldest time stamp
- Option 2:
	- Keep pages in a queue
		- On reference, move the page to the front of queue
		- On eviction, replace page at back of queue
	- Need costly operation to manipulate queue on EVERY memory reference!


FIFO: First In, First Out
- Advantages
	- Simple implementation
- Disadvantages
	- Ignores locality of process’s memory references
	- Suffers from Belady’s Anomaly (miss count can increase with more page frames)
LRU: Least Recently Used
- Advantages
	- Captures locality reasonably well
	- Does not exhibit Belady’s Anomaly
		- Stack algorithm: pages in smaller memory always appear with larger memory
- Disadvantages
	- Adds software overhead to every memory references
	- Vulnerable to scanning reference patterns

Approximating LRU
- Exact LRU is too costly.
- LRU approximations use the PTE reference bit (R bit)
	- All R bits are initially zero.
	- As processes execute, R bits are set to 1 for pages that are accessed.
- On eviction…
	- No longer knows the exact order of use, but still knows the pages that were (or were not) used
	- Degrades to FIFO if eviction happens infrequently
		- Why?
		- Solutions?

Second chance algorithm
- Maintain a FIFO queue
- On eviction, inspect reference bit of the head of queue
	- If R bit is 0, replace the page
	- If R bit is 1, clear R bit, re-queue page, and try again
	- Pages that are used often enough to keep reference bits set will not be replaced
- Can combine with Modify bit to create 4 classes of pages
	- E.g., prefer clean pages
	- Sometimes called “Not Recently Used” algorithm
- Problem:
	- Difficult for CPU to maintain a queue on every memory access
	- Need something we can actually implement

Clock algorithm
- Practical implementation of Second Chance
- Replace page that is “old enough”
- Arrange all physical page frames in a circular list
	- Like a clock
- A clock hand is used to select a good LRU candidate
	- Sweep through the pages in circular order
		- If R bit is off, it hasn’t been used recently
			- What is the minimum “age” of a page if R bit is off?
		- If R bit is on, turn it off and go to next page
- If memory is large, accuracy of usage information degrades

Counting-based replacement
- Count number of uses of a page
- Least-Frequently-Used (LFU)
	- Replace the page used least often
	- Pages that are heavily used at one time tend to stick around even when not needed anymore
	- Newly allocated pages haven’t had a chance to be used much
- Most-Frequently-Used (MFU)
	- Favours new pages
- Neither is common, both are poor approximations of OPT

Combining recency and frequency
- IDEA: Single-use pages should be replaced quickly
	- Don’t evict pages that are likely to be used again.
	- Variations on this idea lead to a collection of scan-resistant algorithms
		- LRU/k, 2Q, ARC, LIRS
- We will look at the Simplified 2Q algorithm
	- Johnson & Shasha, VLDB 1994
	- Maintain two queues, called A1 and Am in the paper
		- A1 is a limited-size FIFO queue
			- holds pages that have only been used once
		- Am is the ‘main’ queue, LRU order
			- holds most of the pages

Simplified 2Q algorithm
- On reference to page p
	- Equivalently, the frame allocated for page p:
- if p is on the Am queue then:
	- move p to MRU position of Am
- else if p is on the A1 queue then:
	- remove p from A1
	- put p on Am queue in MRU position
- else // first access we know about for p
	- put p on A1 queue in youngest position
- To allocate a frame for page p
	- i.e., when all frames are in use
- if A1’s size is above its threshold then:
	- evict oldest page from A1 (first-in)
	- put p in the freed frame
- else:
	- delete LRU page from Am
	- put p in the freed frame

Page buffering
- Previously, we assumed the replacement algorithm is run and a victim page selected when a new page needs to be brought in
- Most of these algorithms are too costly to run on every page fault
	- Maintain a pool of free pages (free page list)
	- Run replacement algorithm when pool becomes too small (“low water mark”), free enough pages to at once replenish pool (“high water mark”)
		- Uses dedicated kernel thread, the paging daemon
	- On page fault, grab a frame from the free list
	- Frames on free list still hold previous contents, can be “rescued” if virtual page is referenced before reallocation

Thrashing
- Page replacement algorithms should avoid thrashing
	- When most time is spent by the OS in paging data back and forth from disk than executing user programs
	- No time spent doing useful work (making progress)
	- In this situation, the system is overcommitted
		- No idea which pages should be in memory to reduce faults
		- Not enough physical memory for all of the processes in the system
			- E.g., running Window 95 with 4 MB of memory…
	- In worst case scenario, no progress can be made
		- E.g., if system only has one frame available for processes

Possible solutions to thrashing
- fork() returns error if low on memory
	- Only as a preventative measure
- Swap out entire process
	- Write out all pages of a process and suspend it
- Kill a process whenever out of memory (OOM)
	- E.g., Linux oom killer
- Buy more memory
	- Most practical solution
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---