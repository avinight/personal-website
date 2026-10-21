`uc_mcontext` is the machine representation of the saved context

RIP is PC
RSP is stack pointer

rax, rdi, rsp, rip have changed as a result of getcontext()


```sh
gdb ./examine_ucontext

info address main

print (unsigned long) my_context.uc_mcontext.gregs[REG_RIP] - (unsigned long) main
```

setcontext_called is stack allocated -48
err is stack allocated -44

The provided code has a global variable called `my_context`, which is a `ucontext_t` structure.  
Start the debugger on the compiled examine_ucontext program (`gdb ./examine_ucontext`) and then place a breakpoint at the start of `main` and before/after the call to `getcontext()`.

1. Which fields of `my_context` changed due to the call to `getcontext`?
    
    - You can use the gdb command `info registers` to see the values of the registers.
        
    - You can use the gdb command `next` (and `step`) to advance to the next line of code.
        
    - You can use the gdb command `print my_context` to see the values stored in `my_context` (compare this with `info registers`).
        
    - You can use `ptype my_context` to see the type of each field of `my_context`.
        
    - The general CPU registers are saved in the `gregs` array in the `mcontext_t` structure. The sys/ucontext.h file defines constants for the different registers saved in this array. 
2. What is the memory address of `main()`?
    
3. What is the memory address of the program counter saved in `my_context`?
    
4. What is the distance (i.e., number of bytes) between these two memory addresses?
    
5. How are the parameters `argc` and `argv` passed to the `main` function? Hint: Use gdb, then run `disassemble main` in gdb, and then scroll up to see the beginning of the main function. Are there any saved registers in `my_context` that store these parameters? Why or why not?
    
6. Are the variables `setcontext_called` and `err` stored on the stack?
    
7. Does the stack grow up or down? Hint: Calculate the distance between the memory addresses of `setcontext_called` and `err`.
    
8. What is the stack-related data in `my_context.uc_mcontext.gregs`?
    
9. What is the value of the `uc_stack` field in `my_context`? Note: This is _not_ the stack of the running thread
    

Next let us understand how `setcontext` works.

Carefully read its man page so that you can answer the questions below concretely.

1. Why does the program not fail the assertion that comes after the call to `setcontext()` (at the bottom of `main()`)?
2. How does the code reach the line `exit(0)` in `main()`?
3. Why must `setcontext_called` be stored on the stack and not in a reigster?