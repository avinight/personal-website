Tags:

---
Atomicity violations
- The desired serializability among multiple memory accesses is violated (i.e. a code region is intended to be atomic, but the atomicity is not enforced during execution).

Example of an atomicity violation:
```C
Thread 1::
if (thd->proc_info) {
	fputs(thd->proc_info, ...);
}

Thread 2::
thd->proc_info = NULL;
```

Fixed example of atomicity violation:
```C
pthread_mutex_t proc_info_lock = PTHREAD_MUTEX_INITIALIZER;

Thread 1::
pthread_mutex_lock(&proc_info_lock);
if (thd->proc_info) {
	fputs(thd->proc_info, ...);
}
pthread_mutex_unlock(&proc_info_lock);

Thread 2::
pthread_mutex_lock(&proc_info_lock);
thd->proc_info = NULL;
pthread_mutex_unlock(&proc_info_lock);
```

What is serializability?
- Serializability
	- Guarantees outcome of concurrent operations will be equivalent to some sequential execution of the same operations
- Example:
- $T_A$ executes instructions $a_1, a_2, \dots a_n,$ to modify shared data
	- $a_1, a_2, \dots a_n,$ are atomic 
- $T_B$ executes instructions $b_1, b_2, \dots b_m,$ to modify same shared data
	- $b_1, b_2, \dots b_m,$ are atomic
- The outcome of running TA and TB concurrently can only be "$a_1, a_2, \dots a_n,b_1, b_2, \dots b_m$" or "$b_1, b_2, \dots b_m,a_1, a_2, \dots a_n$"
- If a set of operations are intended to be atomic but programmer has failed to enforce that atomicity, the desired serializability can be violated.

Order violations
- The desired order between two (groups of) memory accesses is flipped (i.e., A should always be executed before B, but the order is not enforced during execution)

Example of an order violation
```C
Thread 1::
void init() {
	mThread = PR_CreateThread(mMain, ...);
}

Thread 2::
void mMain(...) {
	mState = mThread->State;
}
```

Fixed example of an order violation:
```C
pthread_mutex_t mtLock = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t mtCond = PTHREAD_COND_INITIALIZER;
int mtInit = 0;

Thread 1::
void init() {
	...
	mThread = PR_CreateThread(mMain, ...);
	
	// signal that the thread has been created...
	pthread_mutex_lock(&mtLock);
	mtInit = 1;
	pthread_cond_signal(&mtCond);
	pthread_mutex_unlock(&mtLock);
	...
}

Thread 2::
void mMain(...) {
	...
	// wait for the thread to be initialized...
	pthread_mutex_lock(&mtLock);
	while (mtInit == 0)
		pthread_cond_wait(&mtCond, &mtLock);
	pthread_mutex_unlock(&mtLock);

	mState = mThread->State;
	...
}
```

# Deadlock

Four conditions need to hold for a deadlock to occur [C+71]:
- Mutual exclusion: Threads claim exclusive control of resources that they require (e.g., a thread grabs a lock).
- Hold-and-wait: Threads hold resources allocated to them (e.g., locks that they have already acquired) while waiting for additional resources (e.g., locks that they wish to acquire).
- No preemption: Resources (e.g., locks) cannot be forcibly removed from threads that are holding them.
- Circular wait: There exists a circular chain of threads such that each thread holds one or more resources (e.g., locks) that are being requested by the next thread in the chain.


Deadlock prevention

Transaction is a mechanism in databases
- start making changes, when satisfied -> commit transaction and perform changes made atomically
- if you don't wanna keep the changes, you can discard it without affecting operations that are using the database.

same concept as a rollback

#1 preferred way of getting rid of deadlock = preventing circular wait

deadlock ordering?

virtualization mitigates "resources are finite" issue of deadlock




<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---