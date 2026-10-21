Processes P1 and P2 have each mapped the same 4MB shared memory region into their address spaces. (You can assume that the mapping is aligned to the start of a page boundary.) The page size on the system is 4096 bytes. Hierarchical page tables are used, but the number of levels, and the bits of virtual address used to index each level are not relevant for this question. 

How many virtual pages are P1 and P2 sharing? (Remember 4MB = 4 * 1024 * 1024). Number of shared pages: 1024 (Enter the number only) 

How many bottom-level page table entries are needed for the shared memory region in total? Number of PTEs: 2048 (Enter the number only) 

How many total physical page frames are needed for the shared memory region? Number of page frames: 1024 (Enter the number only)


Suppose P1 and P2 map this shared region into their virtual address space at some address, which we will refer to as "shared_start". The processes will use the shared space to exchange string messages. Each message is stored as the address where the string starts, the length of the string, and the string itself.  A snippet of code for P1 and P2 is shown in the boxes below. Assume there is proper synchronization, so that the code snippet in P2 runs after the snippet in P1 (sync omitted here to keep it simple). Assume a pointer occupies 8 bytes and an int occupies 4 bytes.

```C
// P1: (assume void *shared_start has been set to the start address of shared memory region)

void *p = shared_start /* p points to start of shared memory region */

char **msgstart = (char **)p; /* msgstart also points to start of shared region */

int *msglen = (int *)(p + sizeof(char *)); /* msglen points 'sizeof pointer' bytes past start of shared region */

*msgstart = p + sizeof(char *) + sizeof(int); /* write start address of message into shared region */

*msglen = strlen("Catch me if you can"); /* write length of message into shared region */

p = p + sizeof(char *) + sizeof(int); /* advance p past message header */

strncpy(p, "Catch me if you can", *msglen); /* copy message into the shared region */
```


```C
// P2:(assume void *shared_start has been set to the start address of shared memory region)

char *msg = (char *)malloc(MAX_MSG_LEN);

void *p = shared_start; /* p points to start of shared memory region */ 

char *copy_from = *(char **)p;

int len = *(int *)(p + sizeof(char *));

strncpy(msg, copy_from, len);

printf("%s", msg);
```

Assume that P1 and P2 both map the shared region to the same virtual address, so that 'shared_start = 0x4000' in both processes. What is the value of the variable 'copy_from' in P2 after this code executes? 0x400c  

What will be output by P2's printf statement? Catch me if you can

Now assume that P1 maps the shared region at address 0x4000 but P2 maps the shared region at 0x8000. What is the value of the variable 'copy_from' in P2 in this case? 0x400c

What will be output by P2's printf statement in this case? There is no way to tell.



Suppose P1 is using 42 pages in its virtual address space (frames are allocated for all 42 of these pages), which are mapped using 3 page frames for page tables (1 page directory, 2 bottom-level page tables). P1 executes childpid = fork(). If **CoW is not used**, how many page frames are allocated when P1 returns from the fork call? Include the space needed for page tables. (Ignore other space that might be needed for OS data structures when creating a new process.)
90
P1 and P2 each uses 42 + 3 frames in total. They do not share any frames.

Suppose P1 is again using 42 pages in its virtual address space (frames are allocated for all 42 of these pages), which are mapped using 3 page frames for page tables (1 page directory, 2 bottom-level page tables). P1 executes childpid = fork(). If **CoW is used**, how many page frames are allocated when P1 returns from the fork call? Include the space needed for page tables. (Ignore other space that might be needed for OS data structures when creating a new process.) Assume that P2 has not run at all, and P1 has executed no instructions except the return from the system call.
48
P1 and P2 share all pages, but they each have their own page table. 3 * 2 + 42 = 48.


Using the same setup as the previous question, suppose P1 has returned from the fork() and has stored the result into a local (stack allocated) variable, childpid. How many page frames are allocated at this point?
49
P1 makes a copy of a stack page, so they are now only sharing 41 pages.