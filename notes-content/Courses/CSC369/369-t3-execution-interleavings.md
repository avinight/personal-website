---
tags:
  - course/csc369
  - computer-science
---
Consider the following pseudo-code:
```C
// globals

int g = 10;  
int *f = NULL;  
mutex m;

// Thread 1

lock(m);  
f = &g;  
printf("%d, ", *f);  
       // do some other stuff  
printf("%d\n", *f);  
unlock(m);

// Thread 2

lock(m);  
f = NULL;  
g = 11  
unlock(m);
```

What are all the possible outputs of this system, given an arbitrary interleaving of Threads 1 and 2?

| 10, 10 | Statements in a critical section protected by a lock cannot be interleaved with statements executed by another critical section protected by the same lock. Either Thread 1 or Thread 2 must acquire the lock first, and complete its critical section, followed by the other Thread. <br><br>If Thread 1 gets the lock first, g has its initial value of 10, and Thread 1 will print 10 twice.                                                               |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 11, 11 | Statements in a critical section protected by a lock cannot be interleaved with statements executed by another critical section protected by the same lock. Either Thread 1 or Thread 2 must acquire the lock first, and complete its critical section, followed by the other Thread. <br><br>If Thread 2 gets the lock first, g will be updated from its initial value of 10 to 11, before Thread 1 sets f to point to g. Thread 1 will then print 11 twice. |


```C
// Thread 1

lock(m);  
f = &g;  
printf("%d, ", *f);  
unlock(m);  
// do some other stuff  
lock(m);  
printf("%d\n", *f);  
unlock(m);

// Thread 2

lock(m);  
f = NULL;  
g = 11;  
unlock(m);
```
What are all the possible outputs of the system now? Note that SEGV means segmentation fault, i.e., the program crashed.

| <span style="background:#ff4d4f">10, 10</span> | This output will happen if Thread 1 runs entirely before Thread 2.                                                                                                                                                                                                                                                                                                              |
| ---------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 10, SEGV                                       | This output will result if Thread 2 runs before Thread 1 executes any statements. When Thread 1 sets f to point to g, the value of g has already been set to 11 by Thread 2, and both print statements in Thread 1 will output '11'.                                                                                                                                            |
| 11, 11                                         | This output will happen if we have the following execution order:<br><br>- Thread 1 runs: locks m, sets f to point to g, executes its first print and unlocks m (this gives the first output '10')<br>- Thread 2 runs: locks m, sets f to NULL and g to 11, unlocks m<br>- Thread 1 runs: locks m, attempts to dereference the NULL pointer f in the argument to printf. (SEGV) |


```C
volatile int counter = 1000;
void *worker(void *arg) {
    counter--;
    return NULL;
}

int main(int argc, char *argv[]) {
    pthread_t p1, p2;
    pthread_create(&p1, NULL, worker, NULL);
    pthread_create(&p2, NULL, worker, NULL);
    pthread_join(p1, NULL);  
    pthread_join(p2, NULL);
    printf("%d\n", counter)
    return 0;
}
```
Assuming `pthread_create()` and `pthread_join()` all work as expected (i.e., they don't return an error), which outputs are possible?

| <span style="background:#ff4d4f">998?</span> | There is a race on the decrement of counter.  If the threads perform the decrement one after the other, the "right" result will occur: 998.                                                                   |
| -------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 999                                          | There is a race on the decrement of counter.  If the threads perform the decrement concurrently, each will read 1000 as the value of the counter, decrement it to 999 and then write 999 back to the counter. |


In the questions 4-8, we suspect there is some broken synchronization. The following multi-threaded code snippet is supposed to add `amount` to the global variable `balance` (as usual). For each of the following, indicate whether the code snippet has a race condition, works correctly, or is broken in some other way (but not a race condition).
```C
void update(int amount) { 
       int tmp = amount;
       lock();	
       tmp = tmp + balance;
       unlock();
       balance = tmp;
}
```

race 
Balance might be updated after unlock before setting it to tmp.

```C
 void update(int amount) { 
       int tmp = amount;
       lock();
       tmp = tmp + amount;
       balance = tmp;
       unlock();
 }
```

works?
<span style="background:#ff4d4f">No, its broken</span>
The code doesn't make any sense because we aren't adding amount to balance.

```C
void update(int amount) {
        lock();
        balance = balance + amount
        lock();
 }
```

works?
<span style="background:#ff4d4f">No, its broken</span>
There are two calls to lock.

```C
 void update(int amount)
        int *tmp = &balance;
       lock();
       *tmp = *tmp + amount;
       unlock();
 }
```

broken?
<span style="background:#ff4d4f">No, it works</span>
This works, but it is silly.  We really don't need a temporary variable.

```C
 void update (int amount) { 
       int tmp = balance;
       lock();
       tmp = tmp + amount;
       balance = tmp;
       unlock();
 }
```

works?
<span style="background:#ff4d4f">no its a race</span>
balance could be updated after setting to tmp, but before the lock.

Given the following program, answer the 3 questions that follow.

```C
int main()  
{  
    int c = 0;   
    for (int i = 0; i < 3; i++) {   
        if (fork() == 0) {   
            printf("%d ", c + i);   
            fflush(stdout);   
        }   
        else {   
            c = c + i + 3;   
        }   
    }   
  
    return 0;   
}
```

How many times is `fork()` called? Draw a diagram to receive partial marks (correct answer without a diagram will receive full marks). Hint: a diagram that shows program execution will help with the next two questions. Remember to label the variable values.

7

Choose all the output sequences shown below that are valid program output. Marks will be deducted for incorrect answers.

<span style="background:#ff4d4f">Correct Answer: 9 4 0 5 1 2 6</span>
Correct!: 0 1 4 6 5 9 2 
0 1 5 4 9 6 2
6 4 9 5 0 1 2
0 4 2 6 1 5 9
<span style="background:#ff4d4f">Correct Answer: 4 0 1 6 9 2 5</span>

Suppose you are running this program on a shared machine and there is a per-user process limit of 4 that is enforced within a time window of 1 minute, i.e., after creating 4 processes, you must wait for a minute before being allowed to create any more processes. As a result, after 4 processes are created, all `fork()` invocations will fail, _even after the previously created processes terminate_. Check all the output sequences shown below that are valid program output. Marks will be deducted for incorrect answers.

0 3 7
5 4 0
<span style="background:#ff4d4f">Correct Answer: 9 4 0</span>
9 0 1
Correct!: 0 1 6
<span style="background:#ff4d4f">Correct Answer: 4 0 1</span>

Suppose two threads execute the following C code concurrently.

```C
int x = 5, y = 0, z = 0;

void thread_1() {  
    if (x < 0) {  
        z = y - x;  
    }  
    else {  
        z = y + x;  
    }  
}

void thread_2() {  
    y = 9;  
    x = -3;  
}
```

6, 5, 14, 12