
What goes into OS?
- Synchronization
- Scheduling
- Memory management
- Inter-process communication
- Exception handling
- Networking
- Authentication
- Access control
- File system
- Device drivers

If setting the privilege level is a privileged operation, how can the CPU execute OS code again after it switches to user mode?
- **A hardware interrupt causes a switch to system mode.**
- **Code executing in user mode can cause an exception, which causes the CPU to switch to system mode.**
- It can't. OS code never runs after switching to user mode.
- Code executing in user mode can call OS functions and execute them.


Interrupts should be enabled whenever the processor is in user mode. (True)

Interrupt and exception handlers always execute in system mode. (True)

The transition from user mode to system mode requires hardware support. (True)

When power is first supplied to a computer system, the CPU starts in system mode. (True)

What instructions/operations **must** be privileged to ensure correct operation of the machine?

- **Disabling interrupts**
- Enabling interrupts (False, though it usually should as good practice)
- **Writing to hardware device registers**
- **Halting the CPU**
- Reading the current privilege level from a CPU register (False)
- Reading the CPU register that holds the address of the Interrupt Descriptor Table (False)
- **Writing the CPU register that holds the address of the Interrupt Descriptor Table**
- **Setting the CPU mode (also known as current privilege level)**