
What fields will you need in your thread structure? Perhaps the most important is the thread state (e.g., running, etc.). Think about all the states that you will need to support.
- thread state: running, blocked, ready
- thread context (ucontext_t)
	- PC, local vars, stack, two arg registers: %rdi, %rsi
- 


`getcontext` "returns" twice. When it is called directly, it initializes the context structure that is passed as an argument, and then execution continues after the `getcontext()` call. Then, when `setcontext()` is called later, execution returns to the instruction following the `getcontext()` call, which appears to be a second "return", since the code continues running from the instruction following `getcontext()`. For this assignment, you will use this behavior, once when you create a context, and again when you switch to that context. What action will you take in each case? How will you tell which case you are in? (Hint: Look at the T2 tutorial exercise's use of `getcontext()` and `setcontext()`.)


- https://linux.die.net/man/2/setcontext

Most threads are created with `thread_create`, but the initial thread is there before your library is invoked. Nonetheless, the original thread must be able to `thread_yield` to let other threads run, and other threads must be able to call `thread_yield` and let the original thread run. How is this going to work?

Note that when the initial thread in a C process returns, it calls the exit system call, which causes the OS to destroy the process, even if you have other user-level threads in the process that want to run. It is possible for the initial tread `(TID == 0)` to call `thread_exit()` while other threads are still running. How will you ensure that the program exits only when the last thread in your system exits?

**Be careful.** It is dangerous to use memory once it has been freed. In particular, you should not free the stack of the currently running thread in thread_exit while it is still running. So how will you make sure that the thread stack is eventually deallocated? How will you make sure that another thread that is created in between does not start using this stack (and then you inadvertently deallocate it)? You should convince yourself that your program would work even if you used a debugging `malloc` library that overwrites a block with dummy data when that block is `free()`'d.
- Note that the stack of the initial thread `(TID == 0)` was not dynamically allocated by the threads library, and cannot be freed when this thread calls thread_exit. How will you detect and handle this case?

**Be careful.** If you destroy a thread that is holding or waiting on a resource such as a lock (we will be implementing locks in the next assignment), problems can occur. For example, deadlock may occur because the thread holding the lock may not have a chance to release the lock. Similarly, if the thread waiting on a lock is destroyed, then the thread releasing the lock may wake up some other thread incorrectly (e.g., due to reusing thread id). For this reason, it is important to ensure that when thread_kill is invoked on a thread, the target thread should **not** exit immediately. Instead, the next time the target thread runs, it should notice that it has been killed and exit. How will you implement this functionality? In practice, operating systems provide a signal handler mechanism that allows threads to clean up their resources (e.g., locks) before they exit.

What are the similarities and differences between `thread_yield` and `thread_exit`? Think carefully. It will be useful to encapsulate all that is similar in a common function, which will help reduce bugs, and possibly make your code simpler.



a stub function implicitly defines another function:
- a thread exit