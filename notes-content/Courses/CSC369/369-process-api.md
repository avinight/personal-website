Tags:

---

Why are child and parent processes (CPU scheduler) designed to be non-deterministic?

Why do we transform the child process for `exec()` instead of creating a brand new process?
- Because the shell is a user program.
- It lets the shell run program after call to `fork()` and before call to `exec()`
- We can for example redirect the output of a program to a file other than STDOUT
- We can call different processes and make our own shell runnable program that include a chain of commands.

RTFM - Read the fucking manual

### Lecture
`fork()`
- If there is an error, parent will get error and child will not need to be called in the first place.

order that you see prints depends on the scheduler. 
`fork()` is not sufficient to run a different program; violates UNIX design.
We therefore have `exec()`.
	successful `exec()` call means we're running a new program. A no return function since the original function doesn't exist anymore. 
	- Why is it designed this way?

`exit()`
- can't free something thats being used.
- a process that isn't freed is called **zombie/defunct**






<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---