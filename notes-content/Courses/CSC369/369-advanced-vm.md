Tags:

---

# Implementation concerns

Addressing page tables
- Process page tables maintained by OS and stored in memory
- Where do we store process page tables?
	- i.e., in which address space?
- Physical memory
	- Only on some embedded systems or when a computer boots up
	- Once the kernel is up, virtual memory is activated
	- Kernel is addressing, we use physical memory directory (real mode) no translation

Direct-mapped kernel virtual memory address
- Where do we store process page tables?
- Virtual memory
	- Option 1: direct-mapped kernel virtual addresses
		- Does not use TLB
		- Found on MIPS architectures
	- Easy to address, requires simple translation
		- E.g., on 32-bit machine, subtract 0xC0000000
		- Kernel address 0xC0001000 = 0x1000 physical address
	- Pro: Simplifies hardware support for address translation
	- Con: Cannot perform compaction on process page tables
		- Cannot remap a kernel virtual address to a different physical address (direct mapping doesn't allow)

Kernel page table
- Where do we store process page tables?
- Virtual memory
	- Option 2: kernel page table
		- TLB also used to translate kernel virtual address to physical address
		- Found on most architectures
		- Entire kernel address space can be swapped out to disk
			- Improves memory efficiency by swapping out cold (unused) kernel data
	- Addressing process page tables requires translation
		- Can we page out the kernel page table?
			- No!
			- Must wire important code and data
				- E.g., page fault handler, disk device driver, etc.

wiring or pinning refers to marking certain pages of memory as non-swappable.

Managing swap space
- Option 1: Use raw disk partition
	- Faster – skips FS code
	- Requires disk reformat to resize
- Option 2: Use ordinary large file in file system
	- More flexible – can grow if more swap space is needed
	- Swap file can become fragmented over time
- When should swap for virtual pages be allocated / freed?
	- On process start up / shutdown?
		- In practice, most of swap space is wasted
	- On page out / page in?
		- Depends if clean eviction is supported

Virtual memory area
- Virtual address space contains regions with different modes
	- Demo: pmap command
		- Modes: read/write/execute/shared/locked (R)
- Where does that information get stored?
	- Not the purpose of the page table
- Abstraction: each process maintains an "address space“
	- A representation of its view of memory
- Because this view is sparse, we have areas that are valid (allocated) and areas that are not
- The address space is populated with virtual memory areas (VMAs)

VMAs track allocated addresses
- VMAs give us a way to track space that the process expects to use, and some policy associated with it.
	- E.g. <start, size> of code area, <start, size> of initialized data area, <start, size> of stack area, etc.
	- Initial VMAs are created as part of handling exec() system call.
	- Additional VMAs are created in response to mmap() system calls.
- Linux doesn't allocate memory on malloc()/mmap()/sbrk() call
	- Memory isn't allocated until the first time it is used
- SEGFAULTs!
	- The page fault handler checks the VMAs first to see if the faulting address is valid.

Fixed vs variable space allocation
- In a multiprogramming system, we need a way to allocate memory to competing processes
- Problem: How to determine how much memory to give to each process?
- Fixed space algorithms
	- Each process is given a limit of pages it can use
		- When it reaches the limit, it replaces from its own pages
	- Local replacement algorithm
	- Processes may do well while others suffer
- Variable space algorithms
	- Process’ set of pages grows and shrinks dynamically
	- Global replacement – one process can ruin it for the rest (contrary to OS goal of process isolation)
	- Local replacement – replacement and set size are separate
- Space allocation is independent from replacement policy

Working set model
- A working set of a process is used to model the dynamic locality of its memory usage
	- Defined by Peter Denning in 1960s
- Definition: The set includes the reference at time t, but does not include the reference at $t-\Delta$ $$WS(t,D) = \{\text{pages } P \text{ such that } P \text{ was referenced in the time interval } [t, t-D)\}$$- t = time, D = working set window (measured in page refs)
- A page is in the working set (WS) only if it was referenced in the last D references

Working set size
- The working set size is the number of pages in the working set
	- The number of pages referenced in the interval $[t, t-D)$
- The working set size changes with program locality
	- During periods of poor locality, you reference more pages
	- Within that period of time, the working set size is larger
- Want the working set to be the set of pages a process needs in memory to prevent heavy faulting
	- Each process has a parameter D that determines a working set with few faults
	- Denning: don’t run a process unless working set is in memory

Working set problems
- Problems
	- How do we determine ∆?
	- How do we know when the working set changes?
- Too hard to answer
	- Working set is not used in page replacement algorithms
- However, it is still used as an abstraction
	- The intuition is still valid
	- When people ask, “How much memory does Firefox need?”, they are in effect asking for the size of Firefox’s working set
- Approximations may be useful in practice

# Advanced virtual memory functionality

Sharing
- Private virtual address spaces protect applications from each other
	- Usually exactly what we want
- But this makes it difficult to share data (have to copy)
	- Parents and children in a forking Web server or proxy will want to share an in-memory cache without copying
- We can use shared memory to allow processes to share data using direct memory references
	- Both processes see updates to the shared memory segment
		- Process B can immediately read an update by process A
	- How are we going to coordinate access to shared data?
- How can we implement sharing using page tables?
	- Have PTEs in both tables map to the same physical frame
	- Each PTE can have different protection values
	- Must update both PTEs when page becomes invalid

Mapping shared regions
- Can map shared memory at same or different virtual addresses in each process' address space
- Different: Flexible, but pointers inside the shared memory segment are invalid
- Same: Less flexible, but shared pointers are valid
- <span style="background:#9254de">What happens if a pointer inside the shared segment references an address outside the segment</span>
	- What does this mean?


Copy on write
- OSes spend a lot of time copying data
	- System call arguments between user/kernel space
	- Entire address spaces to implement fork() <- worst offender
		- copy entire VAS, which is slow and memory consuming
		- must avoid copying until we have to
- Use Copy on Write (CoW) to defer large copies for as long as possible, hoping to avoid them altogether
	- Instead of copying pages, create shared mappings of parent pages in child virtual address space
	- Shared pages are protected as read-only in parent and child
		- Reads happen as usual
		- Writes generate a protection fault, trap to OS, copy page, change page mapping in page table, enable write permission, restart write instruction
	- How does this help fork()? (Implemented as Unix vfork())

Without copy on write
- Unix fork() system call makes a copy of a process, including virtual address space

With copy on write
- Page tables are copied, but point to same page frames. Pages are write-protected in parent and child
- Any write to a page, from parent or child causes a protection fault.
	- OS makes a copy of the page frame, updating page tables to writeable

<u>Mapped files</u>
mmap(addr, length, prot, flags, fd, offset)
- Map length bytes from file fd starting at offset to add
- References to virtual addresses in mapped range refer to corresponding offsets in file
- pagein / pageout ops apply to named file, not swap
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---