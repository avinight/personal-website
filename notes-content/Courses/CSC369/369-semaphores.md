---
tags:
  - course/csc369
  - computer-science
---
Tags:

---

What are semaphores?
- an ADT that provides synchronization
- internal data
	- An integer counter variable accessed through 2 atomic operations
	- A queue of waiting threads
- Operations
	- wait (also called P or decrement)
		- Decrement the variable and block if resulting value is negative
	- signal (also called V or increment or post)
		- Increment the variable, unblock a waiting thread if there are any


<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---