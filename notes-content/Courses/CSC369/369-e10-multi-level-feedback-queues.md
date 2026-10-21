---
tags:
  - course/csc369
  - computer-science
---
Tags:

---

Consider a multi-level feedback queue scheduler where the first two rules are specified below. (A and B are processes)

There are three queues labeled by their priority:  High, Medium, Low

- Rule 1: If Priority(A) > Priority(B), A runs (B does not).
- Rule 2: If Priority(A) = Priority(B), A and B run in round-robin fashion using the time slice (quantum length) of the given queue.

These two rules are not sufficient to fully describe the algorithm, so we need to come up with some additional rules.

For the first 4 questions below, define a new rule that will address the question. The final question does not require a new rule.


What is the preferred length of the time quantum of the highest priority queue compared to that of lower priority queues?
- **shorter than others** - Short time quantum preferentially give interactive jobs more priority while ensuring fairness by having longer time quantum for low priority jobs.
- same as others
- longer than others

In which queue should a job start when it enters the system?
- **high priority** - We typically want a job to start in the highest priority queue because we don't know anything about it.
- medium priority
- low priority

What event causes a job to move to a lower-priority queue?
- We are looking for something that indicates the job is not high priority.  One possibility is that if the job uses up its full time slide, it move to a lower priority queue.

How does the algorithm prevent starvation?
- We need some way to periodically move all the jobs from the low priority queue to the high priority queue.

What type of processes are given high priority?
- CPU-intensive jobs
- **IO-intensive jobs**
- **Interactive jobs**
- Steve Jobs
The answer here will depend on what causes a process to move to a lower priority queue.

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---