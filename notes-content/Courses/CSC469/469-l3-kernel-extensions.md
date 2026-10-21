---
tags:
  - course/csc469
  - computer-science
---

- Add new functions to OS "on the lfy"
- Why do we need to extend the OS?
	- Customize and existing part, enable specialized or customized implementation for efficiency
	- New hardware -> new device drivers
	- Fixing bugs -> swap out subsystem in the kernel
- Why on the fly?
	- Avoid rebooting and/or rebuilding the OS
	- Support long-running systems that must stay online
	- Enable rapid development and deployment
- Why?
- How?
	- Allow some OS function to run outside the kernel (microkernel)
	- FUSE is running in userspace, then we don't need to recompile and reboot the kernel
	- Give everyone their own virtual machine
	- Allow users to modify the OS

Loadable Kernel Modules
- Why not just virtual machines?
	- VMs isolate functionality, but requires a full OS
	- We usually only want to modify or replace a small part of the kernel
	- Too heavyweight for small changes
- Solution
	- Allow parts of the kernel to be dynamically loaded / unloaded
	- Requires dynamic relocation and linking
- Common in monolithic kernels, especially for device drivers
	- Eg. FreeBSD, Windows, Linux, etc.
	- These are known as modular kernels

Linux Loadable Kernel Modules
- Module writer must define (at least) two functions*
	- init_module
		- Code executed when module loads
	- cleanup_module
		- Code executed when module unloads
	- Module functions can refer to any exported kernel symbols
- Module is compiled in relocatable .ko (kernel object) file (since 2.6)
	- Requires kernel source tree for kernel that module will be loaded into
	- Since Linux 2.4, you can name them whatever you want by use the `module_init` and `module_exit` macros

- `obj-m` This means it's part of a module, otherwise it will get compiled in the big kernel image

Using Modules
- `insmod`
- `rmmod`
- `lsmod`
- `modprobe`

Exercise. insmod is a program that calls systems calls init_module, finit_module

Tracking modules
- Kernel has a linked list of module objects
	- struct contained in the module memory itself
- Each loaded module corresponds to one struct modules
- Linux way of constructing a doubly-linked list

rmmod
- unlinks module from kernel safely
1. Needs to enusre no one is using module first! Dereferencing dangling pointer -> crash kernel
	- refcount is incremented whenever module is used
	- This includes:
		- other modules that depend on it
			- source_list identifies this
		- user processes currently using it
		- active kernel operations
2. Invokes module-provided exit / cleanup functions
3. Frees memory


Problems with module approach
- requires stable interfaces
	- Modules depend on kernel ABIs remaining compatible
	- Version checks help, but mismatches still occur
- Unsafe by design
	- Module code runs with full kernel privleges 
	- Bugs or malicious behavior can crash or take over the system
	- Bug in the module, is a bug in the kernel
- Example: VMWware Workstation Driver
	- Temporarily modified low-level CPU state to implement virtualization
		- "hijacks" machine by changing the interrupt descriptor table (IDT) base register, then jumps to code in the VM application!
	- IDT base register -> register in charge of knowing where the interrupt handlers are
		- Switching that out means it has unlimited power
		- You could steal anything you want if it was malicious

- Kernel modules are trusted code 
Extend exercise 1. -> reroute system call table to whatever you want


Alternate kernel-level schemes
- Trusted compilers (or certification aurthority) and digital signatures
	- Very the source of code added to the kernel
	- Authenticate who produced the code
	- Trust decision still required
	- Signed code still runs with full privileges
- Proof-carrying code
	- Code Consumer (OS) specifies what extensions are allowed to do
	- Code Producer (Extension) supplies a proof of safety
	- OS validates the proof before loading
	- Proofs are easy to check, but hard to produce

G. Necula - Safe kernel extensions without run-time checking
A maze is "safe" if there's a path through it
	Easy to check a path, but hard to generate
- Producers have to generate the path (proof generation)
- Consumers have to validate the path is correct (proof checking)

Alternates
- Sandboxing (software fault isolation)
	- Limit memory references to per-module segments
	- Check for certain unsafe instructions
- Examples:
	- SPIN (U. of Washington)
		- Modula-3 + trusted compiler - safety properties provided by language
		- Problems with dynamic behaviour (e.g. "while(1)")
	- Vino (Harvard)
		- Sandboxed C/C++ code called "grafts"
		- Timeouts to guard against misbehaved grafts
		- Resource limits + transactional "undo"
		- FAT pointers
	- Byte-Granularity Isolation (Microsoft) - BGI

Fast and flexible extensions prevent take over of kernel

eBPF
- "extended Berkeley Packet Filters"
- Language-level VM within Linux kernel 
	- language level, not hardware level because there is no isolation
	- Register-based VM 
	- Custom 64-but RISC instruction set
	- Bytecode verifier
- Restrictions are placed on eBPF programs for safety
	- Limited number of instructions
	- Controlled memory referencing
	- Originally, no loops allowed
		- Verifier wasn't able to guarantee the program terminates
		- Bounded loops were introduced in Linux 5.3

Before eBPF: BPF
- "The BSD Packet Filter": A New Architecture for User-level Packet Capture
	- Register-based language-level VM to run user programs for packet capture & filtering inside the BSD Unix kernel
		- 2 registers
		- 22 instructions
		- No backward branches (no loops)
	- Safety / restrictions not mentioned in paper

History: eBPF
- BPF instruction set was too limited
- Linux introduced new "internal" BPF
	- User programs written "classic" BPF were translated to internal BPF
	- New virtual machines had 10 64-bit registers (enough to pass function arguments in regs), new BPF_CALL instruction to call kernel functions, ~100 instructions, and other features
- "internal" BPF was made available to users as "extended" BPF soon after (patch mid-2014)
	- Verifer checks user programs at load time
		- Termination(no loops), no unintialized reads, no out-of-bounds memory access
	- Added support for data "maps"

Classic usage: optimize packet filtering

Running eBPF Programs
- Must be "attached" to code points in kernel
	- Event triggers execution of eBPF code
- Used for:
	- Classic network filtering and monitoring
	- Intrusion detection
	- Restriction system calls
		- E.g., seccomp (Secure Computing Mode)
	- Debugging and performance analysis

How does it work?
- Userspace has one overloaded system call, bpf()
	- `int bpf(int cmd, union bpf_attr *attr, unsiged int size);`
	- Meaning of `attr` depends on the command
- For loading an eBPF program `cmd = BPF_PROG_LOAD`
	- For load, `attr` includes a program type, and the list of instruction in the program
	- Type determines what eBPF program is allowed to access in kernel
- In-kernel verifier checks safety of eBPF program
	- Terminates, bounded loops, no unreachable code
	- No out-of-bounds accesses, no uninitialized reads
	- Access to kernel functions restricted by program type

- How is eBPF program "attached" to the kernel?
	- i.e., so that it gets invoked at the desired time
	- Depends on the kind of event
		- For sockets, setsockopt()
			- SO_ATTACH_BPF
		- For perf events, ioctl()
			- PERF_EVENT_IOC_SET_BPF
- Other commands attach, create and access maps
	- Need to specify:
		- map type, max # of elements, key size and value size (in bytes)

