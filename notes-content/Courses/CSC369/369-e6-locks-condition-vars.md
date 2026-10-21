Select all the true statements about the following code. Multiple threads may be executing code using these variables at the same time.  The variables 'mutex', 'no_space' and 'num_spaces' are global and shared by all threads.

```C
    // assume all variables are correctly initialized
    
    pthread_mutex_lock(&mutex);
    while(num_spaces == 0) {
        pthread_cond_wait(&no_space, &mutex);
    }
    num_spaces++;
    pthread_mutex_unlock(&mutex);
```

num_spaces can not be 0 when pthread_cond_wait returns
- False
The mutex is held by this thread while it is blocked in pthread_cond_wait.
- False, The thread releases the lock while it is blocked, but acquires it again when it returns.
The mutex is held by this thread whenever it checks the value of num_spaces
- True
The mutex is held by this thread when the while loop terminates.
- True
It would be safe to put the num_spaces++ line after the pthread_mutex_unlock.  In other words, we would get the correct result regardless of the ordering.
- False


