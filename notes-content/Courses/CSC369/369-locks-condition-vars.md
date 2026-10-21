---
tags:
  - course/csc369
  - computer-science
---
Tags:

---

Why do we need condition variables?
- With locks, we can enforce mutual exclusion.
- Sometimes we also need to enforce order of thread execution.
	- E.g., cars wait for traffic light to turn green.

General idea
- Want to put threads to sleep until condition is satisfied
	- Need to hold a lock while checking shared state to see if condition is already satisfied.
	- If not, need to release the lock before putting thread to sleep.
	- Need to re-acquire lock when thread wakes up, to confirm that the condition is now satisfied (and possibly to do other work on variables that the lock protects).
- When another thread does something that causes the condition to be satisfied, it needs to wake up one or more of the waiting threads.

Encapsulates pattern of “release mutex, sleep, re-acquire mutex”.
	- Internal data is a queue of waiting threads.
Operations are (each sub-bullet of these is atomic):
- `pthread_cond_wait(pthread_cond_t *cv, pthread_mutex_t *mutex)`
	- Releases mutex, adds thread to cv’s wait queue cv, and sleeps
	- Re-acquires mutex before return
- `pthread_cond_signal(pthread_cond_t *cv)`
	- Wake one enqueued thread
- `pthread_cond_broadcast(pthread_cond_t *cv)`
	- Wake all enqueued threads

<span style="background:#ff4d4f">CAUTION! If no one is waiting, signal or broadcast has no effect.</span>

Always used together with locks
- The lock protects the shared data that is modified and tested when deciding whether a thread needs to wait or signal (or broadcast) to let another thread proceed.

General usage of condition variables
```C
pthread_mutex_lock(mutex);
while(condition not satisfied) {
pthread_cond_wait(cond, mutex);
}
... // do stuff
pthread_cond_signal(cond);
//or pthread_cond_broadcast(cond);
pthread_mutex_unlock(mutex);
```

Signal
- the condition variable implementation will pick one “lucky” thread to wake up.
Broadcast
- all the threads wake up, but only one of them re-acquires the mutex (when the broadcaster releases it) and can thus proceed.
- Every other awoken thread will wait.
- However, they are no longer sleeping in the cv queue, they are waiting to acquire the mutex!
- The condition that the threads were waiting for (and that was satisfied when the broadcast was sent) might no longer hold when they get to acquire the mutex.

two ways to initials pthread_cond_t

```C
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
pthread_cond_init(&cond, NULL);
```

<span style="background:#ff4d4f">TIP: ALWAYS HOLD THE LOCK WHILE SIGNALING</span>
##### Producer/Consumer problem

circular buffer implementation
```C
void add_to_buffer(buf_t *b, int value) {
	b->data[b->in_pos] = value;
	b->in_pos = (b->in_pos + 1) % MAX;
	b->num_elements++;
}
```

The producer and consumer are two threads that share the same resource through a pipe. The problem is that locks around the critical section don't suffice. We can use a condition variable instead to mitigate the problem

What are Mesa semantics?
- interpretation of what a signal means

producer/consumer problem is a thief problem

```C
int loops;
cond_t cond;
mutex_t mutex;

void *producer(void *arg) {
	int i;
	for (i = 0; i < loops; i++) {
		Pthread_mutex_lock(&mutex);           // p1
		while (count == 1)                    // p2
			Pthread_cond_wait(&cond, &mutex); // p3
		put(i);                               // p4
		Pthread_cond_signal(&cond);           // p5
		Pthread_mutex_unlock(&mutex);         // p6
	}
}

void *consumer(void *arg) {
	int i;
	for (i = 0; i < loops; i++) 
		{Pthread_mutex_lock(&mutex);          // c1
		while (count == 0)                    // c2
			Pthread_cond_wait(&cond, &mutex); // c3
		int tmp = get();                      // c4
		Pthread_cond_signal(&cond);           // c5
		Pthread_mutex_unlock(&mutex);         // c6
		printf("%d\n", tmp);
	}
}
```


Spurious Wakeup:
We use while loop to check `bar.ready` to prevent spurious wakeup, which means the threads  
waiting on the condition variable may return from the `cond_wait` without any thread issuing a  
`cond_signal` or `cond_broadcast`. Without the while-loop, this would allow threads to leave the  
barrier before all other threads had arrived, breaking the barrier semantics. (Many thread library  
implemenations allow this behavior, although current pthreads on Linux does not.)



<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
https://en.wikipedia.org/wiki/Spurious_wakeup
https://askldjd.com/2010/04/24/the-lost-wakeup-problem/