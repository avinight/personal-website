---
tags:
  - course/csc369
  - computer-science
---
A _barrier_ is a synchronization primitive that allows a set of threads to wait at some code point until all threads have reached that point. In other words, no thread is allowed to proceed past the barrier until all threads have arrived at the barrier. It is commonly used in parallel simulations, where all threads must complete their updates for the current timestep or phase before the next timestep or phase can begin.

