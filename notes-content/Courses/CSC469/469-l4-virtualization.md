
What is virtualization? Term conflated along many multiple axes
1. What is virtualized?
	- Hardware (e.g. CPU, memory, devices)
	- OS interface (e.g. processes, files, syscalls)
	- Language runtime (e.g. JavaScript, eBPF)
2. Who enforces isolation?
	- Hardware (e.g. MMU, privilege level)
	- Kernel (e.g. namespaces, cgroups)
	- Software (e.g., runtime checks, verification)

namespace: A way to partition global OS resources, in a namespace, you can only see these 
- some number of users
- Docker

cgroup (control group): limits how much resources you can use in that group

System virtual machines that share a kernel doesn't exist
OS requires shared kernel
Language runtime requires shared 


What is a virtual machine?
- Earliest formal definition
- An efficient isolated duplicate of a real machine
- Must have the following essential characteristics 
	- Efficiency
		- Most instructions run directly on hardware
	- Resource control
		- VMM (virtual memory monitor) has complete control of system resources
	- Equivalence (transparency)
		- Execution is essentially identical to real hardware
- Which category of virtualization does this apply to?
	- Anything software enforced isolation is not included
	- Hardware enforced isolation is the only category
- Later, broader usage of the term "virtual machine"
- A virtual machine is software that provides the illusion of a different execution environment 
- What is the distinction?
	- A matter of perspective
	- Conventional software is developed/compiled for a specific OS and hardware
		- Smith & Nair (2004) - Virtual Machines: Versatile Platforms for Systems and Processes
	- A virtual machine changes the execution interface that software sees

What interface is virtualized?
- ISA
	- Defines instructions, registers, memory model
	- Program execute virtual instructions
	- Examples: system virtual machines, emulators, Language runtimes
- ABI
	- Defines system calls, calling, conventions, binary format
	- Program execute native instructions
	- Examples
		- containers, API translation

Types of virtual machines
- i.e., how they are implemented
- Process virtual machines
	- Provide a virtual execution environment for a single process
	- Created and destroyed along with the process
	- May virtualize either ISA or ABI
- System virtual machines
	- Provide a virtual hardware platform
	- Support a full guest operating system
	- Virtualize the machine ISA (directly or indirectly)
	- Result in a complete system environment

Why virtual machines?
- The original motivation was expensive hardware, it helped them manage the problem of people wanting to use different VMs on the same hardware.
- Today's motivation is that we want software to be portable, VMs provide protection and isolation guarantees. 
- VMs like Docker help us maintain portability and reliability/reproducibility.
- VMs today help us run legacy applications on modern hardware.

Type I Hypervisor
- AKA "classic" VMM
	- VMM runs or bare hardware, everything else runs on top
		- VMM is most privileged software, everything else less privileged
	- Xen is a type 1 hypervisor

Type II Hypervisor
-AKA "hosted" VMM
- Virtualizing software installed on top of (or within) existing OS
	- e.g. VMWare Workstation, Oracle VM VirtualBox, QEMU (+KVM)
	- Virtual machine appears as a regular process to the host OS
	- VMM relies on host Os for device derivers and services
Virtualizability
- Dual-mode operation
	- User mode vs privileged (kernel) mode
- Controlled entry into privileged mode
	- Traps or exceptions for privileged operations
- Memory relocation and protection
	- Isolate guest memory from host and other guests
- Interrupt and exception handling
	- VMM must regain control on interrupts and faults

Responsibilities of a VMM
1. Dispatcher
	- Regains control on traps, interrupts, and exceptions
2. Allocator
	- Manages CPU, memory and device resources
3. Interpreter
	- Handles or emulates sensitive operations

Instruction requirements
- Virtualizing is easy if all instructions are virtualizable, but
- Privileged instructions
	- required to trap if not executed in supervisor mode
- Sensitive instructions
	- affect the operation of the system in some way
- THEOREM: An efficient VMM may be constructed if the set of sensitive instructions is a subset of the set of privileged instructions

Intel Pentium Virtualizability
- 17 instructions are sensitive but not privileged
	- VM Ware used binary rewriting to deal with this
	- Xen required changes to the OS
		- Paravirtualization
			- guest OS is modified to cooperate with the VMM
			- i.e. it knows that it is running in a virtual machine
	- Intel VT, AMD-V (Pacifica) fixed this

SIDT, PUSHF, POPF, CALL are not privileged but not sensitive
LIDT is privileged

CALL is used with system calls/task switching. Some variations of CALL require being privileged.

Disco
- Targets large shared-memory multiprocessors (ccNUMA)
	- To run multiple copies of Silicon Graphics IRIX OS on a Stanford Flash shared memory multiprocessor
- Constraints:
	- No hardware changes
	- unmodified commodity OSes
- Goal: virtualization beyond correctness and isolation
	- Manage locality, sharing and scalability at system scale.

Virtualization on ccNUMA
- ccNUMA (cache coherent NUMA)
	- single shared physical address space
	- Memory access latency depends n physical location
- Some OSes (e.g. IRIX) assume control over placement
	- Page allocation, migration, and scheduling are tightly coupled
- But a naive VMM hides physical topology
	- Guest OS makes locality decisions with incomplete information
- Result
	- Correct virtualization behaviour preserved, but...
	- Performance can degrade significantly.

Extended Motivation
- Most commodity OSes did not scale well to large ccNUMA systems
	- Lock contention
	- Memory architecture
- Fault containment worsened at scale
	- More processors -> higher failure rates
- Customized operating systems
	- Take a long time to build
	- Cost a lot of money
	- Hardware innovation outpaced OS adaptation
- VMs + a smart VMM
	- Reduce the gap between hardware innovation and release of adapted system software
	- Compatibility with legacy applications

Contribution
- Scalability
	- Partition a large ccNUMA machine into manageable virtual machines
	- Schedule virtual processors to balance load
- Locality-aware memory management
	- Place and migrate memory to stay close to the CPUS that use it 
- Memory sharing
	- Avoid duplication of identical pages across virtual machines
- Fault containment 
	- Failures contained within a single virtual machine

Challenges
- Overheads
	- Instruction execution, exception processing, I/O
	- Memory
		- Code and data of hosted operating system
		- Replicated buffer caches
	- Resource management
		- Lack of semantic information
			- Idle loop vs. lock busy-waiting
			- Page usage, e.g. shared lock
	- Communication and sharing
		- Not a problem -> use distributed protocols

Disco interface
- VCPUs provide abstraction of a MIPS R10000 processor
	- Virtualizes privileged instructions, MMU, trap architecture
	- Non-privileged instructions exxecuted directly on hardware
	- Enabling/disabling interrupts, accessing rpviileged registers 
		- Memory-based interface to VMM
- Guest physical memory
	- i.e what Guest OSes see
	- Contiguous address space, starting at address 0
	- Physical-to-machine address translation managed by VMM
		- Called "second" TLB in the paper

- Disco interface (cont'd)
- I/O devices
	- Virtual devices exclusive to VM
	- Physical devices multiplexed between virtual ones
	- Special interface to SCSI disks and network devices
	- Interpose on DMA calls
	- Disk:
		- Set of virtualized disks to be mounted by VMs
		- Copy-on-write disks; for persistent disks, uses NFS
	- Network:
	- Virtual subnet across all virtual machines
	- Uses copy-on-write mappings -> reduces copying, allows sharing

x86 is a hardware managed TLB. MIPS is software managed.
read only guest page table

Xen virtualization
- Technically, two kinds
- Paravirtualization
	- Guests run a modified OS
		- Introduced direct paging:
			- guest OS can read PPN to MPN map, maintains VPN to MPN translation in page tables
			- Xen still controls actual writes to page tables
		- High performance on x86
- Hardware-assisted virtualization
	- CPUs that support virtualization
	- Unmodified guest OSes

- Xeno-aware -> paravirtualization

Domain0 controls all of the other guests. 
- Privileged access to devices
- Manage other domains, handling I/O on their behalf.

Move device drivers into the OS 
- Makes the hypervisor much thinner -> isolation/reliability

How does it compare to disco?
- Design choices
	- Less complete virtualization
	- Domain 0 responsible for VM management, policy, device access, etc.c
	- Interface close to hardware, e.g., explicit hypercalls, paravirtualized I/O
- Results
	- Low, overhead, high performance
	- Strong performance isolation between VMs
	- Requires more guest OS changes than Disco
- All the cool details are in the paper

Xen I/O (2003)
- At the time, DMA and MMIO are already common
- Direct memory access (DMA)
- Memory-mapped I/O (MMIO)
	- Hardware device registers are mapped into the (machine) physical address space
		- ie.e each register has its unique physical address

IOMMU protects other devices from being written to by the guest OS.









