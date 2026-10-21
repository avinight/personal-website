---
tags:
  - course/csc209
  - computer-science
---
Tags:

---
### Problem with Blocking Reads
---
Blocking: Parent process doesn't go on to execute next instruction, but sits and waits for the child to write something

Read on a pipe blocks until there is something to read or the other end of the pipe is closed (return 0).


![[Pipe Read Blocking.png]]

### Introducing Select
---
Reading from multiple sources with blocking read calls can lead us to wait indefinitely on one source while the other source has data available. We can avoid this situation by using a system call named select.

The select() system call blocks until one or more of a set of file descriptors becomes ready.
```C
#include <sys/time.h> /* For portability */ 
#include <sys/select.h>

int select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds, struct timeval *timeout);

// Returns number of ready file descriptors, 0 on timeout, or –1 on error
```

But what about the first parameter? Select's first parameter is a bit confusing. What you need to do is set this parameter to be the value of the highest file descriptor in your set *plus one*.

![[Follow Up Question 2 (3).png]]
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- [https://youtu.be/3lQBSWeEseU](https://youtu.be/3lQBSWeEseU)
- [https://youtu.be/d2ROpbcIXd4](https://youtu.be/d2ROpbcIXd4 "Share link")
