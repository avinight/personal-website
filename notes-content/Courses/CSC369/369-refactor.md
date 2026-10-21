---
tags:
  - course/csc369
  - computer-science
---
privileged instructions:
disabling interrupts
writing to device registers
halting cpu
setting the cpu mode

optional:
enabling interrupts in some architectures

- login is done in user process
- OS doesnt run if no interrupt or exception occurs


text and data region

- pcb can only belong to one queue at a time

- what is the interrupt that starts the OS?

when exec succeeds, the process running is wiped out/overwritten
cannot free process pid and exit code
- process were waiting for has not exited
- step 5, 6 context switch
- waitpid
- reap: get rid of zombies
- wait or waitpid will kill child process
- exec on child, not parent bc shell pid would keep changing


