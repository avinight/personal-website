# l2 Kernel systems and modules
- Layered systems: Kernel services internally organized in layers
- Open systems: Independently replaceable system components
- Monolithic kernels: Entire kernel runs in privileged mode, e.g., Linux, Windows
- Microkernels: Non-essential services run in user space
	- Why do (device drivers, file systems, network stack) run in user space?
- Exokernels

Early Layered System
"THE multiprogrammed system" Dijkstra, 1st SOSP, 1967
ID-10-T error
![[Multiprogrammed System.png]]

Properties of Layered systems
- Each layer has well-defined function and interface to layer above/below
	- Provides easier-to-use abstraction for higher layers
	- Layer provides interface to layer above. can use/invoke interface of layer below.
- Advantages:
	- Each layer can be designed, implemented and tested independently
		- Exhaustive testing possible due to limited interactions
	- Processes at any level can only invoke services of level below
		- No circular wait, no deadlock
- Disadvantages:
	- Hard to partition functions into this strict hierarchy
	- Why is console below other peripherals?
	- Peripherals need to invoke message interpreter to report errors

Multics
- Stands for "multiplexed information and computing service"
- Example of layered system
	- Enforces a strict ordering of privilege and responsibility 
- Paper describes 8 protection rings
	- inspired x86 to use the term "rings" for its 4 CPU privilege levels
- CPL Current Privilege Level

Strict hierarchy of layers is not easy to implement all the time.

An open system
![[Open System.png]]

Performance was the design goal over protection and isolation.
Back then, the typical machine only had 64KB of memory.
No clean line between kernel and applications.

Properties of open systems
- Applications, libraries, kernel all in the same address space
	- Bugs propagate across components -> crash the kernel / make unsafe
	- Debugging in an open system -> providing reliability is hard
- Open systems used to be very common <= no concept of protection/isolation
- Advantages:
	- Very good performance (no overhead for user <=> system crossings)
	- very extensible/customizable; maximize flexibility and performance
	- works well for single-user
- Disadvantages:
	- No protection between kernel and/or apps; no isolation
	- Not very stable
	- Composing extensions can lead to unpredictable behaviour

A monolithic OS
![[Monolithic OS.png]]

Properties of Monolithic kernels
- OS is all in one place, below the "red line"
- Applications use a well-defined system call interface to interact with kernel
- Advantages:
	- Good performance
	- Well-understood, easy for kernel developers
	- High level of protection between applications
- Disadvantages:
	- No protection between kernel components
	- Not (safely, easily) extensible
	- Overall structure becomes complicated (no clear boundaries between modules)

Microkernel OS
![[Microkernel OS.png]]

Properties of Microkernels
- Design philosophy: protected kernel code provides minimal "small, clean, logical" set of abstractions
	- Tasks and threads
	- Virtual memory
	- Interprocess communication IPC
- Everything else is a server process running at user-level
- Advantages:
	- OS personalities
	- Extensible: add a new server to add new OS functionality
	- Kernel does not determine OS environment
		- Allows support for multiple OS personalities
		- Need an emulation server for each system
		- All applications run on same microkernel
		- Applications can use customized OS
	- Mostly hardware agnostic
		- Threads, IPC, some user-level servers don't need to worry about underlying hardware
	- Strong protection
		- Even of the OS against itself, i.e., the parts of the OS that are implemented as servers
	- Easy extension to multiprocessor and distributed systems
		- Message passing through kernel <- IPC
- Disadvantages:
	- Performance: System calls can require a lot of protection mode changes
	- Expensive to reimplement everything with a new model
		- OS personalities are easier to port to new hardware after porting to microkernel, but porting to microkernel may be harder than porting to new hardware
	- Bad past history <= IBM Workplace OS

Microkernel System Call
1. Application calls `read()`, traps to microkernel
2. microkernel sends message to Unix Personality requesting read
3. Unix personality sends message to File System Server FSS asking for data
4. FSS receives message and begins processing
5. FSS sends message to microkernel asking for disk blocks
6. Microkernel sends data back to FSS
7. FSS sends message to UNIX Personality with results
8. Unix Personality recieves message with data
9. Unix Personality sends data to Application
10. Application receives data

L4 microkernel IPC
Push out services as possible and keep necessary parts in the kernel
Mach vs L4
- 20x improvement in IPC performance <- what is the assumptions
- What workload? short messages and synchronous calls that aren't buffered

L4 revolutionized the minimality principle.
- A concept is tolerated inside the microkernel only if moving it outside the kernel would prevent the implementation of the system's required functionality.

Two basic mechanisms
- IPC - synchronous message passing
- Mapping - all access to memory, devices

userspace linux on top of l4 proves microkernels are slow

Why use a microkernel if your Linux applications are 5-7% slower than on native Linux kernel?
- kernel is more customizable
- more integrated, better for protection/isolation

What other benefits or advantages might arise from small L4 code size?
- Easier to maintain and debug
- 

Why has microkernels not replaced monolithic kernels?
- L4 formal verification is possible
- Device drivers are harder to write


Solving IPC problem

How far can we take minimality?
- Microkernels: minimal set of abstractions and mechanisms
- Exokernel: MIT research project
	- Claim: OS abstractions are bad because they:
		- deny application-specific optimizations;
		- discourage innovation;
		- impose "mandatory costs".
	- Solution: Separate concept of protection from abstraction and management
	- Follows E2E principle: minimal, fewest hardware abstractions possible
	- Exokernel is basically a secure resource multiplexor
		- Applications link directly with a library that provides OS functions (libOS)
	- Drawbacks?

Dropping OS abstractions are not new
exokernels and vms push policies out of the kernel.

