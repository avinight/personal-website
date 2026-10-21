---
tags:
  - course/csc369
  - computer-science
---

```C
sem_t sem;  
  
void thread1() {  
	sem_wait(&sem);    
	if (thd->proc_info) {        
	/* nothing */        
	fputs(thd->proc_info, ...);  
		/* nothing */
	}  
	sem_post(&sem);
}  
  
void thread2() {  
    sem_wait(&sem); 
    thd->proc_info = NULL;  
	sem_post(&sem);  
}  
  
int main() {  
    sem_init(&sem, 0, 1);
    ...  
}
```

Fix the following ordering violation using a semaphore.
```C
sem_t sem;  
mThread = NULL;

void thread1() {  
    /* nothing */  
    mThread = PR_CreateThread(mMain, ...);  
    sem_post(&sem);  
    ...  
}

void thread2() {  
    sem_wait(&sem);  
    mState = mThread->State;  
    /* nothing */  
    ...  
}

int main() {  
    sem_init(&sem, 0, 0);  
    ...  
}
```


1. Break the property that threads hold resources allocated to them (hold and wait) by acquiring all locks at once, atomically. This gets all needed resources at the same time.

2. Break the property that threads claim exclusive control of resources that they require (mutual exclusion) by designing various data structures without locks at all. In other words,  we can use architectural support to create lock-free data structures.