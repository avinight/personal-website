---
tags:
  - course/csc369
  - computer-science
---


```C
// Global variable(s)
Sem mutex = sem_init(1); // global
int total = 0;

// Thread A
sem_wait(mutex);
total = total + 1;
sem_signal(mutex);

// Thread B
sem_wait(mutex);
total = total + 1;
sem_signal(mutex);
```

Suppose Thread A executes line 1 and then Thread B executes line 4. What is the outcome for the two threads?

Group of answer choices
- Thread A and Thread B both enter the critical section.
- **Thread A enters the critical section. Thead B is blocked inside sem_wait.**
- Thread A is blocked inside sem_wait. Thread B enters the critical section.
- Thread A and Thread B are both blocked inside sem_wait.

Suppose we replace the initialization with sem_init(0). Thread A executes line 1, Thread B executes line 4 as in the previous question. What is the outcome?
- Thread A and Thread B both enter the critical section.
- Thread A enters the critical section. Thread B is blocked in sem_wait.
- Thread A is blocked in sem_wait. Thread B enters the critical section.
- **Both Thread A and Thread B are blocked in sem_wait.**
Suppose we replace the initialization with sem_init(2). Thread A executes line 1, Thread B executes line 4 as in the previous question. What is the outcome?
- **Thread A and Thread B both enter the critical section.**
- Thread A enters the critical section. Thread B is blocked in sem_wait.
- Thread A is blocked in sem_wait. Thread B enters the critical section.
- Thread A and Thread B are both blocked in sem_wait.

Use semaphores to guarantee that a1 happens before b2 and b1 happens before a2. Remember to set initial values for any semaphores you create.  Write your answer in the text box below.

Thread A
statement a1
statement a2
Thread B
statement b1
statement b2

<span style="background:rgba(163, 67, 31, 0.2)">Solution</span>
```
Sem sem1 = sem_init(0)
Sem sem2 = sem_init(0)

Thread A
Statement a1;
sem_signal(sem1);
sem_wait(sem2);
Statement a2;

Thread B
Statement b1;
sem_signal(sem2);
sem_wait(sem1);
Statement b2;
```

Select the synchronization mechanism that best completes the sentence:
- A **semaphore** has a numeric value.
- If signal is called with a **condition variable** and no thread has called wait, it has no effect.
- If signal is called with a **not true**, it decrements the variable.
- If wait is called with a **condition variable**, the thread will block until another thread calls signal or broadcast.
- Using a **not true**, the thread that called wait must be the thread that most recently returned from a call to signal.
- Using a **lock**, the thread that called unlock must be the thread that most recently returned from a call to lock.
- A lock must be passed into a **condition variable** wait call because the lock is released while the thread is blocked.