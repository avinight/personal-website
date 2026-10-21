functions
- `interrupt_handler` : for timer interrupt
- `set_interrupt`
- `set_signal`

- `sigprocmask`
- `sigismember`
- `unintr_printf`
- `va_start`
- `va_end`
- `interrupts_set` : 

- `sigaction`
```C
/* The sa_mask field of struct sigaction specifies signals that
* should be blocked while the signal handler is running.
* The default behavior is to add the signal that triggered the
* handler to this set, so it will be blocked while the handler runs.
* This prevents recursive interrupts, where another interrupt occurs
* before the previous interrupt handler has finished running.
*/
/* Initialize sa_mask to the empty set. This will allow all signals
* except SIG_TYPE to be delivered while the signal handler is
* running. For example, you can use ctrl-c to kill the process.
```
- `SA_SIGINFO`
- `sigset_t`
- `timespec`
- `setitimer`

# Questions
The function that handles the timer interrupt is called:
	register_interrupt_handler
	set_interrupt
	set_signal
	**interrupt_handler**
	interrupts_enabled
	interrupts_quiet

The signal that is delivered to the process when the timer expires is:
	SIGHUP
	SIGUSR1
	**SIGALRM**
	SIGVTALRM
	SIGPROF

During the handling of the timer interrupt, which of the following signals can be delivered to the process? (select all that apply)
	**SIGINT**
	**SIGKILL**
	**SIGSEGV**
	SIGALRM
	**SIGSTOP**
<span style="background:#ff4d4f">On the wiki it says that SIGSTOP/SIGKILL are not handled.</span>

Read the code for the set_interrupt() function and the man page for setitimer.

True or False? After the call to set_interrupt(), the timer will automatically fire every SIG_INTERVAL microseconds.
	True
	**False** - <span style="background:#ff4d4f">depends on system timer resolution/load?</span>

What does the interrupts_on() function do?
	Registers a handler function for the timer interrupt signal.
	Unblocks the timer interrupt signal and returns true if the operation succeeds.
	**Unblocks the timer interrupt signal and returns true if the signal was previously unblocked.**
	Unblocks the timer interrupt signal and returns true if the signal was previously blocked.
	Returns true if interrupts are currently enabled, without changing anything.

True or False? Interrupts are disabled in the saved my_context structure after the first call to `getcontext()` in the `save_interrupt()` function. (HINT: complete the `printf("1. in saved my_context...")` statement.
	True
	**False**

True or False? Interrupts are disabled in the saved my_context structure after the second call to `getcontext()` in the `save_interrupt()` function. (HINT: complete the `printf("2. in saved my_context...")` statement.
	**True** - How? - clear the interrupt handler and start populating it with new interrupts.
	False

How does the process signal mask compare to the signal mask in the saved context at the `printf("3. in process signal mask...")` line in the `save_interrupt()` function? 
	**They are the same.** - <span style="background:#ff4d4f">Why?</span> 
	Interrupts are disabled in the saved signal mask, but enabled in the process signal mask.
	Interrupts are enabled in the saved signal mask, but disabled in the process signal mask.
	It depends on whether we at the first execution of the 'printf("3. ...")' line, or the second one that follows setcontext.

Are interrupts enabled or disabled on return from the `save_interrupt()` function?
	Enabled
	**Disabled**

What is the purpose of the unintr_printf() function?
More Questions:
- What will the output of this function look like if interrupts are disabled when it is called?
- What will the output of this function look like if interrupts are enabled when it is called (and the interrupt handler is being loud)?
- How does the output change if the signal handler uses write() instead of printf()? (See interrupt.c and Makefile)

	It is a replacement for the printf() function that is safe to use in the signal handler. - <span style="background:#ff4d4f">Why not safe to use?</span>
	**It ensures a timer interrupt signal cannot occur in the middle of a printf().**
	Both of the previous answers are correct.

Look at the code for the `unintr_printf()` function in interrupt.c, and consider this alternate implementation:

```C
int unintr_printf(const char *fmt, ...)  
{  
    int ret;  
    /* bool enabled; */  
    va_list args;  
  
    interrupts_off(); /* enabled = interrupts_off(); */  
    va_start(args, fmt);  
    ret = vprintf(fmt, args);  
    va_end(args);  
    interrupts_on(); /* interrupts_set(enabled); */  
    return ret;  
}
```

Is there an issue with the alternative implementation? If yes, what could go wrong?
	There is no problem with this implementation.
	**If the caller had interrupt off, then interrupt would be unexpectedly turned back on.**
	If the caller had interrupt on, then interrupt would be unexpectedly turned off.
	If the caller had interrupt off, this function would not work properly.
	If the caller had interrupt on, this function would not work properly.

We should only turn interrupts on before returning if they were on when we entered the function.


<h6 style="font-weight: normal;">See Also</h6>

---
- https://www.man7.org/linux/man-pages/man3/getcontext.3.html
- https://www.man7.org/linux/man-pages/man3/sigismember.3p.html
- https://www.man7.org/linux/man-pages/man3/pthread_sigmask.3p.html
- https://www.man7.org/linux/man-pages/man2/setitimer.2.html
- https://www.man7.org/linux/man-pages/man7/signal.7.html
- https://en.wikipedia.org/wiki/Signal_(IPC)
<h6 style="font-weight: normal;">References</h6>

---