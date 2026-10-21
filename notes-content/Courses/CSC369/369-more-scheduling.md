---
tags:
  - course/csc369
  - computer-science
---
Tags:

---

## Priority scheduling
---

What is priority inversion?
- A low priority task may prevent a high priority task from making progress
- Priority inversion happens when a lower priority thread prevents a high priority thread from running.

Single-level Queue Scheduling
- One global ready queue
- High overhead
	- Either search or insertion will be O(n)
		- Depends on whether ready queue is sorted
	- Happens whenever a thread becomes runnable

How to adjust criteria for choosing a particular thread based on history in a MLQ?
- Can boost priority of threads that have waited a long time (aging)
- Can prefer threads that do not use full quantum
- Can boost priority following a user-input event
- Can adjust expected next-CPU-burst

What is priority inheritance?
- A protocol that temporarily boosts the priority of a lower-priority task (holding a resource) to match the highest-priority task waiting for that resource.
- Allows low-priority tasks in critical sections to preempt medium-priority tasks.
	- Ensures low-priority tasks release held resources ASAP.
- Tasks can use inherited priority when acquiring more resources, e.g.:
	1. Task L needs R1 and R2, Task L acquires R1 with priority L.
	2. Task H needs R1, but it is unavailable (shares priority with Task L).
	3. Task L acquires R2 with priority H.
Not a general solution to problems with priority scheduling. Usually used in real time scheduling only.

Proportional-share scheduling
- We want each USER not each PROCESS to obtain their fair share of the CPU
- Group processes by user or some other means
- Ensure that each group receives a proportional share of the CPU
	- Shares do not have to be equal
- Law of large numbers guarantees all users get their fair share.

Lottery scheduling

Unix scheduling
- The goal of the unix scheduler is to favour interactive processes
- time between interrupts is smaller than time slice.

Aging with Unix scheduling
- MLFQ with Round Robin within each priority queue
- Priority is based on process type and execution history
$$P_j(i) = \text{base}_j + \frac{\text{CPU}_j (i-1)}{2} + \text{nice}_j$$
$$\text{CPU}_j(i) = \frac{U_j(i)}{2} + \frac{\text{CPU}_j (i-1)}{2}$$
- $P_j(i)$: priority of process j at beginning of interval i; <u>lower values equals higher priorities</u>
- $\text{base}_j$ : base priority of process j
- $\text{nice}_j$ : user-controllable adjustment factor value between `[-20, 19]`, negative number means increasing actual priority.
- $U_j(i)$: processor utilization of process j at interval i
- $\text{CPU}_j(i)$: exponentially weighted average processor utilization by process j through interval i

<h6 style="font-weight: normal;">See Also</h6>

---
- https://www.rapitasystems.com/blog/what-really-happened-software-mars-pathfinder-spacecraft
<h6 style="font-weight: normal;">References</h6>

---