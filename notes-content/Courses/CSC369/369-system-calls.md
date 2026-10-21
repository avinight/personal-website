---
tags:
  - course/csc369
  - computer-science
---

Tags: #lecture 

---


### Lecture

What is a function call?
- activation frame/stack (if function is called inside a function)
- same address space

What is a system call?
- "function call that invokes the OS"
- What can a user do to talk to the OS? Interrupts

Boundary crossings
- **interrupt** -> hardware interrupt
- **exception** -> software interrupt; instruction steps that just occured
- **trap** is an intentional exception
- **fault** is something that happens randomly; not aware of.

System call interface

Why are system called this way?
- enforce separation of user space to kernel space.
- Bad design if CPU only works for one OS, therefore system calls are only for OS so that one instruction for all system calls.

System call operation


System calls in linux
- `syscall(..., sizeof(msg)-1)` <- we don't send a C string.
- hide info checking

`write()` is a system call and a C library function.
`clone()` is a better version of `fork()`
- `fork()` takes a copy of parent process
- `clone()` virtualizes the child process

supply pointer is a null pointer, then you can't copy from a null pointer (unsafe)

check that its safe to copy data into the user address space


If more than 6 parameters are needed, the rest of the params are packaged into a struct and a pointer points to that struct for that system call function.

take a pointer from user space and 

System Calls
what about pointers?
write is a system call and a c library function
fork is a system call













<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---