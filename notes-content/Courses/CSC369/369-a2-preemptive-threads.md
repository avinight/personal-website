---
tags:
  - course/csc369
  - computer-science
---
we need to add the questions to the anki

0, 1, 2, 3

wait for 3 

1, 2, 3, 0

3: 0

What does preemption mean?
Preemption means the thread scheduler decides when to switch threads, usually in response to timer interrupts. Without preemption, a thread (e.g., the code written by library users) controls thread switching because it needs to invoke `thread_yield` to cause thread switching. With preemption, a thread no longer controls thread switching because the interrupt handler may invoke `thread_yield` to cause thread switching at any time (or after any instruction).