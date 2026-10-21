
Here is the categorization of the given options:

### System Calls:

1. **write()**: Used to write data to a file or output device (e.g., standard output).
2. **getpid()**: Retrieves the process ID of the calling process.
3. **fork()**: Creates a new process (child process).
4. **sbrk()**: Adjusts the program's data segment, typically used for memory management.
5. **mmap()**: Maps files or devices into memory, commonly used for efficient file I/O or memory management.

### Not System Calls:

1. **strcpy()**: A library function that copies a string; implemented entirely in user space.
2. **ceil()**: A library function that returns the smallest integer greater than or equal to a given number; implemented in user space.
3. **printf()**: A library function used to print formatted output to the console; internally, it may call system calls like `write()` but is not a system call itself.
4. **malloc()**: A library function used for dynamic memory allocation; it may internally use system calls like `sbrk()` or `mmap()`, but it is not a system call itself.

Why does the kernel need to validate pointers passed into a system call?  What could go wrong if it did not validate user pointers?

Your Answer:

User-space pointers might reference invalid or inaccessible memory addresses. Moreover, malicious programs could pass pointers to kernel-space addresses, which threatens OS security.

Here is the proper order for executing a system call, numbered from 1 to 5:

1. **Load system call number and arguments into registers**  
    The user-space program prepares the necessary data for the system call by loading the system call number (which identifies the function) and its arguments into specific registers.
    
2. **Execute SYSENTER instruction**  
    The user-space program executes the `SYSENTER` instruction (or a similar instruction, such as `INT 0x80` or `SYSCALL`, depending on the architecture) to transition to kernel mode.
    
3. **Switches mode and invokes system call handler**  
    The CPU switches from user mode to kernel mode, and the system call handler in the kernel takes control.
    
4. **Lookup system call function in syscall table**  
    The kernel uses the system call number (provided by the user program) to find the appropriate system call function in the syscall table.
    
5. **Kernel invokes corresponding function**  
    The kernel calls the function associated with the system call number, passing the arguments provided by the user program. The system call executes and returns a result.