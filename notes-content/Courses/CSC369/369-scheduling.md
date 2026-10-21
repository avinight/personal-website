Tags: #book

---

Crux: How should we develop a basic framework for thinking about
scheduling policies? What are the key assumptions? What metrics are
important? What basic approaches have been used in the earliest of computer systems?

Assumptions
1. Each job runs for the same amount of time.
2. All jobs arrive at the same time.
3. Once started, each job runs to completion.
4. All jobs only use the CPU (i.e., they perform no I/O)
5. The run-time of each job is known.
##### Shortest Job First

- Check SJF example in 373 algorithms i.e. prove that its optimal.

Is average turnaround time optimal?
- Relaxing assumption 1. breaks (A = 100, B = 10, C = 10)
- Relaxing assumption 2. breaks (same time but now B, C arrive 10 steps later)

### Lecture
scheduler is a subset of the processor
improves equalization
ready, blocked, exit queue
invoke context switching for scheduling

metrics:
performance - amount of time each process is spending waiting is minimized.
fairness - each process gets to use the cpu asap.

non pre-emptive - first process will run to completion before next process starts

total wait time - cumulative wait time for each of the processes

FCFS is fair.

- Shortest job first minimizes wait time
	- starvation is possible
	- 

What are the goals of scheduling?
All systems
- Fairness - each process receives fair share of CPU
- Avoid starvation
- Policy enforcement - usage policies should be met
- Balance - all parts of the system should be busy
Batch systems
- Throughput - maximize jobs completed per hour
- Turnaround time - minimize time between submission and completion
- CPU utilization - keep the CPU busy all the time
Interactive Systems
- Response time - minimize time between receiving request and starting to produce output
- Proportionality - “simple” tasks complete quickly
Real-time systems
- Meet deadlines
- Predictability
Goals can conflict

What is short term scheduler? (definition of scheduling in 369)
- Short-term scheduler – happens frequently
- Also called dispatching
- Needs to be efficient
	- Fast selection of next process to run
	- Fast queue manipulation
	- Fast context switches

What happens on dispatch?
- Select next process from ready queue
- Save currently running process state
- Restore state of next process
	- Restore OS control structures
	- Restore registers
		- Includes setting PC to next instruction in this process
- Switch to user mode (if required) 

When to schedule?
- When a process enters Ready state
	- I/O interrupts (e.g., “I/O operation completed”)
	- Signals (e.g., SIGCONT)
	- Process creation (or admission in batch systems)
- When the running process blocks (or exits)
	- Operating system calls (e.g., start I/O operation)
	- Signals (e.g., SIGSTOP)
- When the running process voluntarily yields, e.g., sleep(0)
- At fixed intervals
	- Timer interrupts

Understand round robin algorithm

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---