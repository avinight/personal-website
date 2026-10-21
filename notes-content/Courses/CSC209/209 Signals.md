Tags:

---
### Introduction to Signals
---
`^C` stops/kills process
`^Z` suspends process
`fg` program wakes up process

![[Signals Study Notes.png]]

### Signal Handling
---
We can change the behaviour of a signal by installing a new signal handling function.

The `sigaction()` function in Unix and Linux systems is used to change the action taken by a process on receipt of a specific signal.

Here is its prototype:

```C
int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact);
```

- `signum`: This is the signal number. (The signal being modified.)
- `act`: This is a pointer to a `struct sigaction`, which specifies the new action for the signal. (Before you call sigaction, you will need to initialize this struct.)
- `oldact`: This is a pointer to a `struct sigaction`, where `sigaction()` returns the previous action for the signal. If it's NULL, then the previous action is not returned. (When sigaction returns, holds the previous state of the signal.)

The `struct sigaction` contains at least the following members:

- `void (*sa_handler)(int)`: This is a pointer to a signal-handling function or one of the macros `SIG_IGN` or `SIG_DFL`. (Function pointer for the signal handler we are installing.)
- `sigset_t sa_mask`: This is a set of signals that should be blocked during execution of the signal handler.
- `int sa_flags`: This is a set of flags which modify the behaviour of the signal.

The `sigaction()` function returns 0 on success, and -1 on error.

In summary, `sigaction()` allows you to control how your program behaves when it receives specific types of signals. It's a more flexible and reliable alternative to the older `signal()` function.

`SIGINT` - signal generated when pressed `^C`
`SIGQUIT` - signal generated when pressed `^\`

You cannot change these signals
`sig -KILL` will always terminate the process
`sig -STOP` will always suspend the process


```C
int x = 5;  
  
void handler(int sig) {  
    x += 3;  
	fprintf(stderr, "inside %d ", x);  　　　// Note we don't call exit().
}  
  
int main() {  
    fprintf(stderr, "start ");  
    //                             POSITION A  
    struct sigaction act;  
    act.sa_handler = handler;  
	act.sa_flags = 0;           // default flags
    sigemptyset(&act.sa_mask);  // blocks no signals during handler
    sigaction(SIGINT,&act,NULL);  
  
    //                             POSITION B  
    x += 2;  
  
    //                             POSITION C  
    fprintf(stderr, "outside %d", x);  
  
    return 0;  
}  
```
What does the program print to stderr when it runs without interruption?
- The program prints "start outside 7" to stderr when it runs without interruption.

Here's the breakdown:

1. The program first prints "start " to stderr.
2. Then, it sets up a signal handler for `SIGINT` (which is the interrupt signal, usually sent when you press Ctrl+C). However, if the program runs without interruption, this handler is never called.
3. The program then increments `x` by `2`. Since `x` was initially `5`, `x` is now `7`.
4. Finally, the program prints "outside 7" to stderr, where `7` is the current value of `x`.

So, the complete output is "start outside 7".

What does the program above (from part 1) print to stderr if the user presses Ctrl+C at the moment when the program is at position A?
- start

If the user presses Ctrl+C when the program is at position A, the program will print "start " to stderr.

Here's the breakdown:

1. The program first prints "start " to stderr.
2. Then, it reaches position A, where it starts to set up a signal handler for `SIGINT` (which is the interrupt signal, usually sent when you press Ctrl+C). However, if the user presses Ctrl+C at this exact moment, the signal handler hasn't been set up yet, so the default action for `SIGINT` is taken, which is to terminate the program.

So, the complete output is "start ".

If the user presses Ctrl+C when the program is at position B, the program will print "start inside 8 outside 10" to stderr.

Here's the breakdown:

1. The program first prints "start " to stderr.
2. Then, it sets up a signal handler for `SIGINT` (which is the interrupt signal, usually sent when you press Ctrl+C).
3. If the user presses Ctrl+C at position B, the signal handler `handler` is invoked, which increments `x` by `3`. Since `x` was initially `5`, `x` is now `8`. The handler then prints "inside 8" to stderr.
4. The program/process still runs fully and doesn't terminate because signal handler doesn't call exit().
So, the complete output is "start inside 8 outside 10".

Position C is the same reason, "start inside 10 outside 10"

![[Follow Up Question 2 (2).png]]


https://linux.die.net/man/1/od
https://linux.die.net/man/3/random
https://linux.die.net/man/1/ps
https://linux.die.net/man/1/kill
[https://linux.die.net/man/2/sigaction](https://linux.die.net/man/2/sigaction "https://linux.die.net/man/2/sigaction")

https://linux.die.net/man/2/setitimer
https://www.gnu.org/software/libc/manual/html_node/Setting-an-Alarm.html

### signal.c
---
The signature of a signal handler function in C must be `void handler(int signum)`. This is a requirement of the C language and the Unix/Linux operating system. The operating system invokes the signal handler and passes in the signal number as an argument. It does not provide a way to pass in additional arguments.

To work around this, you can use a global variable to store the name. Here's how you can modify your program:

```C
#include <stdio.h>
#include <string.h>

char name[50]; // Global variable to store the name
void sing(int signum) {
    printf("Happy birthday to you, %s!\n", name);

}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <name>\n", argv[0]);
        return 1;
    }
    strncpy(name, argv[1], sizeof(name) - 1); // Copy the name into the global variable
    while(1) {
        // Infinite loop
    }
    return 0;
}
```

In this code, `name` is a global variable that is used to store the name of the birthday person. The `main` function checks if a name was provided as a command-line argument and copies it into the `name` variable. The `sing` function then uses this name when it prints the birthday message.

### WS8
---
`ps aux | grep <username>`

The command `ps aux | grep <username>` is a combination of two commands `ps aux` and `grep <username>`, connected by a pipe (`|`). Here's what each part does:

1. `ps aux`: This is a command that reports a snapshot of the current processes in the system. The options `a`, `u`, and `x` modify the output of the command:
    - `a`: Show processes for all users.
    - `u`: Display the process's user/owner.
    - `x`: Also show processes not attached to a terminal.
2. `|`: This is a pipe. It takes the output from the command on its left (here, `ps aux`) and uses it as the input to the command on its right.
    
3. `grep <username>`: This is a command that searches the input it receives for lines containing `<username>`. Replace `<username>` with the actual username you're interested in.
    
So, `ps aux | grep <username>` will display a snapshot of all current processes owned by `<username>`.

One more experiment: Run your ﬁnal greeting program in the foreground and kill it with Ctrl-c from the same window. Run it again and from another window, send it the USR1 signal to start the singing. While it is still singing, try to kill your greeting program using Ctrl-c from its own window (like you just did already.) What happens? Why?

sigaction system call isn't called until SIGUSR1 is sent. When SIGUSR1 is sent, sing is called and SIGINT is blocked.
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- [https://youtu.be/3KkLUe5ofM0](https://youtu.be/3KkLUe5ofM0 "Share link")
- [https://youtu.be/Bx5LqlhEzfM](https://youtu.be/Bx5LqlhEzfM "Share link")