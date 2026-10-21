Tags:

---

### Unbuffered I/O
---
Buffering data: system calls may read or write larger chunks of data that the user has specified.

File descriptor: An integer that represents an open file or open communication channel, they are of type int because the OS uses them as indexes in to a table of open files.

3 files are automatically open, stdin (0), stdout (1), stderror (2).
`open()` operates on file descriptors

![[File Descriptor Structure.png]]

### Introduction to Pipes
---
Pipes: a form of interprocess communication

Control d to close standard input in the shell
Close file descriptors is good practice

same read and write system calls can be used for both files and pipes.

![[Pipe Communication Study.png]]

### Concurrency and Pipes
---
Pipes are used to communicate between two operating processes

Producer, Consumer problem; limited buffer space
1. Producer adds to the queue when it is full
2. Consumer removes from the queue when it is empty
3. Producer and Consumer operate on queue simultaneously
	1. OS controls this process so only one process happening at a time

![[Pipe Queue Control.png]]
![[Pipe Process Study.png]]

### Redirecting Input and Output with dup2
---
`grep` looks for lines in the second argument that contain the phrase in the first argument and print output to stdout

output redirection should have stdout go to the file
we don't modify grep to do this.

```C
int dup2(int oldfd, int newfd);

// dup2() makes newfd be the copy of oldfd, closing newfd first if necessary
```

extract file descriptor using `fileno`

A file descriptor is an index in a table stored in the PCB. Contains pointers to data structures containing information about open files. 0, 1, 2 indexes usually point to the console.

Each process has its own set of file descriptors

fork may make file descriptors point to the same object

![[Follow Up Question 4.png]]

### Implementing Shell Pipe operator
---

fileno gets file descriptor

![[Follow Up Question 5 A.png]]
![[File Descriptors Inheritance In Fork Call.png]]


<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- [https://youtu.be/yQv-CT76-HE](https://youtu.be/yQv-CT76-HE "Share link")
- [https://youtu.be/NiHkFY2N7gE](https://youtu.be/NiHkFY2N7gE "Share link")
- [https://youtu.be/EQx2PWVLb4c](https://youtu.be/EQx2PWVLb4c "Share link")
- [https://youtu.be/oRSBV7coCAI](https://youtu.be/oRSBV7coCAI)
- [https://youtu.be/gNHYRQmlrDQ](https://youtu.be/gNHYRQmlrDQ "Share link")
- 