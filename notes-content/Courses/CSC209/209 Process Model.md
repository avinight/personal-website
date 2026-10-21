Tags:

---

### Process Models
---
It makes sense to write programs with other programs.

Program: The executable instructions of a program
- Source code
- Complied machine code

Process: running instance of a program.

Stack: tells us which function we are executing

Process control block (PCB) - Stores the current values of important registers any open file descriptors and open states that the system manages.

top = runs the current processes on the machine (in linux)

Running state = 4 processes can run on 4 CPUs
Ready = could be executing if CPU is available
Blocked = waiting for a processes to happen

init is an operating system process.

![[Process States And States.png]]

### Creating Processes with Fork
---
We don't know which executes first, child or parent process after calling fork().

![[Process Forking Study Note.png]]

![[Fork Process Behavior.png]]

![[Fork Return Value PID.png]]

### Process Relationship and Termination
---

![[Process Relationship And Termination.png]]

![[Process Relationship And Termination (2).png]]

![[Process Termination Macro.png]]

### Zombies and Orphans
---

![[Process Termination And Zombies.png]]

![[Orphan Process Model.png]]

### Running Different Programs
---

![[Process Execution And PID.png]]

```C
void format_name(struct node *head) {
	struct node *curr = head;
	while (curr != NULL) {
		char *ptr = strchr(curr->name, " ");
		int size = strlen(curr->name) - strlen(ptr) - 1;
		char *arr = malloc(sizeof(char) * strlen(curr->name));
		
		strncpy(arr, ptr + 1, strlen(ptr));
		strcat(arr, "-");
		strncat(arr, curr->name, size);
		
		curr->name = arr;
		free(arr);
		
		curr = curr->next;
	}
}
```


<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- [https://youtu.be/qb56U6KxGts](https://youtu.be/qb56U6KxGts "Share link")
- [https://youtu.be/z1MwX0_B_zc](https://youtu.be/z1MwX0_B_zc)
- [https://youtu.be/-RdYxwFlY0k](https://youtu.be/-RdYxwFlY0k "Share link")
- [https://youtu.be/MI_4X6XFauY](https://youtu.be/MI_4X6XFauY "Share link")
- [https://youtu.be/cLY9oSTr9Vw](https://youtu.be/cLY9oSTr9Vw "Share link")
- [https://youtu.be/aU2ttjwCC3M](https://youtu.be/aU2ttjwCC3M)
- 