Tags: #book

---

- time sharing

- challenges in virtualization machinery
	- performance: how can we implement virtualization without adding excessive overhead to the system?
	- control: how can we run processes efficiently while retaining control over the CPU

HOW TO EFFICIENTLY VIRTUALIZE THE CPU WITH CONTROL
- The OS must virtualize the CPU in an efficient manner while retaining control over the system. To do so, both hardware and operating-system support will be required. The OS will often use a judicious bit of hardware support in order to accomplish its work effectively

##### Limited direct execution

- direct execution
	- a process executes its instructions on the CPU without going through a controller
	- run the program directly on the CPU. 
- limited
	- user processes cannot execute privileged instructions
	- without limits on running programs, the OS wouldn’t be in control of anything and thus would be “just a library” 

##### Problem #1: Restricted operations

Crux: A process must be able to perform I/O and some other restricted operations, but without giving the process complete control over the system. How can the OS and hardware work together to do so?

- user mode
	- code that runs in user mode is restricted in what it can do

- kernel mode
	- which the operating system (or kernel) runs in. In this mode, code that runs can do what it likes, including privileged operations such as issuing I/O requests and executing all types of restricted instructions.

- system call
	- system calls allow the kernel to carefully expose certain key pieces of functionality to user programs, such as accessing the file system, creating and destroying processes, communicating with other processes, and allocating more memory.

- trap instruction
	- this instruction simultaneously jumps into the kernel and raises the privilege level to kernel mode; once in the kernel, the system can now perform whatever privileged operations are needed (if allowed), and thus do the required work for the calling process. 

- return-from-trap instruction
	- which, as you might expect, returns into the calling user program while simultaneously reducing the privilege level back to user mode.

- kernel stack
	- On x86, for example, the processor will push the program counter, flags, and a few other registers onto a per-process kernel stack

Very bad idea: 
- How does the trap know which code to run inside the OS? 
	- Clearly, the calling process can’t specify an address to jump to (as you would when making a procedure call); doing so would allow programs to jump anywhere into the kernel
- Thus the kernel must carefully control what code executes upon a trap

- trap table
- trap handlers
- system call number
- 


Privileged op: being able to execute the instruction to tell the hardware where the trap tables are is a very powerful capability.

##### Problem #2: Switching between processes

Crux: How can the operating system regain control of the CPU so that it can switch between processes?



Crux: How can the OS gain control of the CPU even if processes are not being cooperative? What can the OS do to ensure a rogue process does not take over the machine?

- timer interrupt
- interrupt handler
- scheduler
- context switch
- non-cooperative approach

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---