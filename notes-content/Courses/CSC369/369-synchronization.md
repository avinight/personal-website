thread has no way of deciding when a context switch happens

race condition: two concurrent threads manipulated a shared resource without any synchronization
- we need synchronization
race conditions happen at the instruction level

lost update problem -> incrementing to a shared variable without protection from sync

shared resource can have multiple critical sections

`lock()` and `unlock()`
lock function is possibly a blocking call, wait

how do we implement these functions?
```C
lock() {
	disable_interrupts(); // cli on x86
}
unlock() {
	enable_interrupts(); // sti on x86
}
```
- Not safe to allow user-mode processes to use this mechanism
- doesn't work on multiprocessors; doesn't prevent other threads from running on a different processor; only works on uniprocessors
- hardware devices would not get serviced
- one thread modify count at any given time

network card is going to fill out buffer and drop packets if interrupts are turned off
can we make small critical sections? no its very limiting


```C
typdef struct __lock_t { int flag; } lock_t;
void init(lock_t *mutex) {
	mutex->flag = 0; // 0 -> lock is available, 1 -> held
}
void lock(lock_t *mutex) {
	while (mutex->flag == 1) // TEST the flag
	; // spin-wait (do nothing)
	mutex -> flag = 1; // now SET it!
}
void unlock(lock_t *mutex){
	mutex->flag = 0;
}
```

most of the time we dont want to use atomic instructions unless we have to since they're expensive

you can implement locking in user mode (synchronization)
it is possible to context switch during a critical section
- acquiring a lock does not disable interrupt in any way, we just have exclusive access to the shared variable as long as you're holding the lock

problems with spinlocks
- deadlock on priority inversion
- busy waiting
- starvation is possible

what are sleep locks?
- put thread into “blocked” state while waiting to acquire a lock

what is priority inversion?
- https://en.wikipedia.org/wiki/Priority_inversion

https://en.wikipedia.org/wiki/Test_and_test-and-set
https://en.wikipedia.org/wiki/Test-and-set