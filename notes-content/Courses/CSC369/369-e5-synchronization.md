
q1 interleaved schedules
to get 100, you can either run all withdraw then deposit or vice versa

```C
Withdraw(acct, amt) {  
    balance = get_balance(acct);  
    if (balance >= amt) {  
        balance = balance - amt;  
        put_balance(acct, balance);  
    }  
    return balance;  
}

Deposit(acct, amt) {  
    balance = get_balance(acct);  
    balance = balance + amt;  
    put_balance(acct, balance);  
    return balance;  
}
```

The initial balance on an account is $100. Two threads execute concurrently - T1 calls Withdraw(acct, 10) and T2 calls Deposit(acct, 10). Which of the following are possible values for the final balance of the account when both threads have completed?
- 90, 100, 110


The initial balance on an account is $100. Five threads call Deposit(acct, 10) concurrently. What is the minimum final value of the account balance when all threads have completed execution?
- 110

scheduler decides when we context switch


```C
1.  typedef struct __lock_t {   
2.      int flag; // 0 -> lock is available, 1 -> held  
3.  } lock_t;  
  
4.  void **init**(lock_t *mutex) {  
5.     mutex->flag = 0;   
6.  }  
  
7.  void **lock**(lock_t *mutex) {  
8.      while (mutex->flag == 1) // TEST the flag  
9.          ; // spin-wait (do nothing)  
10.     mutex->flag = 1; // now SET it!  
11. }  
  
12. void **unlock**(lock_t *mutex) {  
13.     mutex->flag = 0;  
14. }
```

Mutual exclusion? No.

There is a potential for race condition since test loop and setting the flag are not atomic.  
  
Let A, B be two threads.

A executes line 8. Moves to step 10

B executes line 8. Moves to step 10

A executes line 10

B executes line 10  
  
Both A and B have entered the critical section, thus violating mutual exclusion.
- Mutual exclusion is not satisfied because both threads can read the 'flag' when it is 0 and break out of their while-loop. Both threads can then set the flag = 1 and return from the lock() function having apparently acquired the lock.

The proposed solution satisfies the **Fairness** property. (In other words, a thread that calls lock() will eventually return and be allowed into the critical section, and all threads have a fair chance of being the next to enter.)
- False

Fairness means that all threads have an equal opportunity to acquire the lock and no thread is indefinitely delayed (no starvation). In the context of locks:
1. A thread that calls `lock()` should eventually acquire the lock.
2. Threads should be granted access in the order they attempted to acquire the lock (first-come, first-served).

There is no mechanism to ensure that threads acquire the lock in the order they requested it. When multiple threads are spinning, the CPU scheduler decides which thread will obtain the lock next. A thread that has waited the longest may still lose out to another thread that arrived later. Indeed, this thread may become starved. This is not fair. Hence, this solution does not satisfy the Fairness property.
- First, note that "Fairness" isn't a formally defined property. But, at the extreme, it is possible for an unlucky thread to always see 'flag == 1' when it tests the flag in the while-loop, even though other threads can enter and leave the critical section (locking and unlocking the lock infinitely many times). So, this implementation doesn't guarantee fairness.


The proposed solution satisfies the **Performance** requirement if the lock is _uncontended._ (That is, the flag is always 0 when a thread calls the lock() function.)
- True
If the lock is uncontended, then the while loop will evaluate to false and immediately set the flag to 1, which is a constant time operation. Hence, it satisfies the Performance requirement.
- To acquire an uncontended lock, all a thread needs to do is a compare, a branch, and a store. We can't do better than that. Too bad it doesn't solve the mutual exclusion problem.


```C
1.  typedef struct __lock_t {  
2.      int flag;   
3.  } lock_t;  
  
4.  void **init**(lock_t *mutex) {  
5.      mutex->flag = 0; // 0 -> lock is available, 1 -> held  
6.  }  
  
7.  void **lock**(lock_t *mutex) {  
8.      while (test_and_set(&mutex->flag, 1) == 1)  
9.          ; // spin-wait (do nothing)  
10. }  
  
11. void **unlock**(lock_t *mutex) {  
12.     mutex->flag = 0;  
13. }
```

This satisfies Mutual Exclusion.
- True
test-and-set is an atomic operation. The while loop blocks other threads from entering the critical section by continuously updating the flag to 1 regardless of whether the lock was uncontended or contended (by itself). Hence, only one thread may enter the critical section at a time, satisfying the Mutual Exclusion property.

- test-and-set is atomic, meaning it is indivisible. If the flag is initially 0, and two threads execute test-and-set on flag at the same time, one of them will see an 'old' value of 0 but the other will see an 'old' value of 1 (the result of the other thread setting the flag). So, one thread can break out of the while-loop, return from lock() and enter the critical section, but other threads keep looping until the lock holder calls the unlock() function when it leaves the critical section.

The proposed test-and-set spinlock is **just as fair as** the spinlock using ordinary instructions. The performance when acquiring an uncontended lock will be **worse than** the spinlock using ordinary instructions.