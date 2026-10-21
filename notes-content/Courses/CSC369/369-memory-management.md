---
tags:
  - course/csc369
  - computer-science
---
Tags:

---
Logical vs. Physical address space
- addresses we're looking at are virtual addresses. We cannot see the physical addresses at all.
- we translate between physical and virtual addresses using MMU.
- Why? because of abstraction

Goals of memory management
- Support enough active processes to keep CPU busy
- Use memory efficiently (minimize wasted memory)
- Keep memory management overhead small (minimize wasted CPU/memory while satisfying five basic requirements

What are some requirements of memory management?
- <span style="background:#d3f8b6">Relocation</span>
	- Programmers (or compilers) don’t know what physical memory will be available when a program runs.
	- Long-term scheduler may swap processes in and out of memory
		- Move entire process to disk to relieve memory pressure; not runnable.
		- Need to bring it back to main memory to run, possibly in different location.
	- This implies we will need some type of address translation.
- Protection
	- A process’s memory should be protected from unwanted access by other processes, both intentional and accidental.
- Sharing
	- In some instances, processes need to be able to access the same memory
	- Need ways to specify and control what sharing is allowed
- Logical Organization
	- Machine accesses/addresses memory as a one-dimensional array of bytes
	- Programmers organize code and data in separate logical regions
		- Program text, stack, heap, mapped files, shared libraries, …
	- Need to map between these views, support different locations have different purposes
- Physical Organization
	- Memory and disk form a two-level hierarchy
		- Flow of information between levels must be managed
	- CPU can only access data in registers or memory, not disk

How to meet the requirements?
- Modern systems use virtual memory
- Complicated technique requiring hardware and software support
- Based on simpler techniques of segmentation and/or paging

What is address binding?
- Program binary is loaded into a process’s address space
- Addresses in program cannot be directly used by CPU
	- Programs use symbols (i.e., variable names) to refer to memory locations
	- CPU fetches from, and stores to, real memory addresses
	- Need to translate (map, bound) from symbolic address to physical address

What is address translation?
- Linking variable names to physical locations

When are addresses bound?
Option 1: Compile time
- Must know during compilation what memory locations the process will use when it executes.
- Still used in simple embedded systems
	- `MS-DOS.COM` programs worked like this
- Called absolute code since binary contains real addresses.
- No relocation is possible
	- Cannot run more than one instance of program

Example:
- Programs must be loaded at exact address specified during compilation.
- Overwrites (evicts) any program already located at those addresses.
- limitations and security issues with this type of binding.
- Only simple for embedded system.

Option 2: Load Time (aka Static Relocation)
- The compiler translates symbolic addresses into relocatable addresses within a compilation unit (source file).
- The linker combines multiple object files, resolving external references and assigning logical addresses within the executable.
- The executable includes a relocation table, identifying all addresses that need adjustment at load time.
- The loader adjusts these addresses, translating logical addresses to physical addresses when loading the program into memory.
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---