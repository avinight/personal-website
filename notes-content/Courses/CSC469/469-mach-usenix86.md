---
tags:
  - course/csc469
  - computer-science
---
IPC abstraction was seen as a general means for passing info between programs (as opposed to pipes, widely used at the time.)

1. Proof of Concept
	1. Fix Virtual Memory VM, threads, IPC
2. Microkernel and "single-server" Unix emulation
	1. Take unix kernel and "saw it in half"
3. Microkernel and multiple servers (for FS, paging, network, etc.)
	1. Servers glued together by modules that catch system calls

PoC completed 989
	Unix server, symmetric multiprocessing support (SMP)
- Process abstraction divided into tasks + threads
- VM: large sparse address spaces, sharing, COW, memory-mapped files
- Capability-based IPC, language support for RPC between tasks, etc.
- Commercial deployment

Microkernel and single-server completed and deployed to 10's of machines
Multi-server never fully completed
Hugely influential

Key Mach abstractions
- Tasks
	- Passive, unit or resource allocation (address space, port rights)
- Threads
	- Active, unit of CPU allocation, perform computation, lightweight
- Ports
	- Unidirectional communication channel, message queue
	- Queue has access rights (embodied as capabilities) <= Pass to have right to do this
	- Send/Receive operations require send/receive rights
	- Essentially an object reference mechanism
- Messages
	- Collections of typed data objects, basis of all communication
- Memory object
	- internal unit of memory management
# Paper
- One port per thread

Pascal string, fixed header size, 
Kernel runs on core 0


Simple scenario
- Thread A sends a null message to thread B
	- Both user-level, but lives in different address spaces
- Minimal sequence of actions
	- Thread A (user mode)

IPC theoretical minimum = 5 usec

Idea of the paper:
	Cost is dominated by hardware limit, not kernel design




