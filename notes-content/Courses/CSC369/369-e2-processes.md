---
tags:
  - course/csc369
  - computer-science
---

What information does the operating system need to store about a running process?  (Think of 4 or 5 different things.)
- Process ID
- Memory Management Information
- Program Counter
- Process State
- Open File Descriptors

When can a different process change state from Ready to Running?
- When the current process calls exit()
- When the current process makes a blocking system call.
- When the current process loads a value from memory. (False)
- When a timer interrupt occurs and the OS chooses it to run next.

When can a process change state from Running to Blocked?
- When the process makes a system call that needs to wait for input.
- When the process makes a system call that puts it to sleep.
- When the process makes the exit() system call. (False)
- When a timer interrupt occurs and the OS decides to run a different process. (False)