Tags:

---

A process is a running program
	- Name (PID)
	- Contains address space 
		- code and data for executing the program
		- An execution stack encapsulating the state of procedure calls
	- Program counter for next instruction
	- Set of general purpose registers with current values
	- Set of operating system resources

Process control block (PCB)
	- A data structure where the OS stores data about the process


Virtualization is implemented by time-sharing CPUs

Low level machinery - mechanisms 
	- low-level methods or protocols that implement a needed piece of functionality

High level intelligence - policies
	- algorithms for making some kind of decision within the OS.

Address space
	- The memory that the process can address (called its address space) is part of the process.

Process API (must be included in all interfaces) - consists of calls programs can make related to processes
	- Create
	- Destroy
	- Wait
	- Misc control
	- Status

Loading - takes on-disk program and reads it into the address space of the process

Lazy loading
	- paging/swapping

A process can have 3 states
- ready
- running
- blocked: a process has performed some kind of operation that makes it not ready to run until some other event takes place.

ready -> running (scheduled)
running -> ready (descheduled)

Data structures
- process list for all processes that are ready and some additional information to track which process is currently running. The OS must also track,
- blocked processes; when an I/O event completes, the OS should make sure to wake the correct process and ready it to run again.
- a register context holding for stopped processes, the contents of its registers

Zombie states - process exited in final state but not cleaned up

### Homework
- 100% cpu utilization
- 11 steps
	- 4 to run cpu instruction
	- 1 to run io execution
	- 5 for io time
	- 1 for run io done
- 7 steps
	- 1 to run io execution
	- 5 for io time and 4 for cpu instructions
	- 1 for run io done
- Runs for 11 steps again when order is switched `-S SWITCH_ON_END`
- same thing as before
- system resources may be underutilized with `IO_RUN_LATER` since io could be blocking while another process is running. 10 steps are wasted as a result.
- since `SWITCH_TO_IO` is on, other processes may run while the process that ran the io is blocking for completion. system resources are used effectively in this case. It is a good idea to minimize wait times while other processes are running.

### Context Switching Steps
1. User process is currently running
	- In user mode (recall limited direction execution)
2. Timer interrupt is triggered
	- CPU will finish execution of current instruction first
3. CPU will save PC, SP, and SR, then update them in preparation for interrupt handling
4. Interrupt handler will save other registers on the stack
5. Save context for current running process (A)
	- Notice while running the interrupt handler, GPREGS are clobbered 
6. Load context for next running process (B)
	- This replaces the values of all registers with values from context(B)
7. Restore GPREGS for user process B
	- This replaces the values of all registers with values from context(B)
8. Last instruction of interrupt handler is `iret`
	- It restores PC, SP, and SR, clears the interrupt request, then resumes execution
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---