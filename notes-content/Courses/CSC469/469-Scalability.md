What is scalability?
- Ideal scalability (aka. linear scalability) means application does N times as much work on N cores as it could on 1 core.

Why does OS scalability matter?
- Poor OS scalability can eliminate parallelism that applications already have

Scaling independent users

Scaling Existing OSes
- We add more processors and more memory

Internal shared structures affect "independent" requests, limits scalability

Areas of concern (Scalability tends to break down)
- Statistical counters
	- Widely used to track variety of system properties
	- Frequently updated, rarely read
- Reference counters
	- Used to prevent freeing of an object that is still in use
	- May be frequently read and updated, but exact value is rarely needed. Except zero vs. non-zero
- Memory management
- Processor scheduling

Simple Shared Counter Example
- Small number of processors
- Cost of operation is small and stable, large grows
- More processors more contention on same memory locations, cache line bouncing

Solution: Per-CPU data
- OS assigns each CPU an integer id at boot time
	- Linux: access with `smp_processor_id()`
- Basic data structure is an array with an entry for each CPU
		`int counter[NUM_CPUS];`
- `counter[smp_processor_id()` is the data structure for current CPU

Up to 16 processors there is no difference
- A cache line is typically 64 bytes / 4 byte counter = 16

If all Per-CPU counters live in the same cache line, 
- contention will drop 

Per-CPU array can lead to false sharing problem
- Each CPU has own variable, but several per-CPU variables are on same cache line
- Modification of one causes invalidations in other CPU's caches
- Solutions?
	- Use padding so each per-CPU variable lies on different cache line

```C
struct padded_int {
	int val;
	char padding[60];
};
struct padded_int counter[NUM_CPUS];
```

alignas directive

Padded Per-CPU counter, stable performance. No contention or cache line bouncing

Insights and Approaches
- Shared data is the enemy of scalability
	- Distribute data structures
	- Use per-CPU data whenever possible
		- With padding to cache lines
- Minimize locking and expensive atomic operations
- Ideas from research have been adopted by mainstream
	- UofT/IBM Tornado/K42 barrel fish projects showed techniques to improve scalability

# An analysis of Linux Scalability to Many Cores
----

Methodology
Repeat 1-3
1. Run application
	1. Use in-memory file system to avoid disk bottleneck
2. Find scalability bottlenecks
3. Improve Linux kernel to remove bottlenecks

- Stop when no more scalability bottleneck in OS
	- Either application or hardware may still present some bottlenecks

What applications to use?
- Think about what we really want to measure
	- Only Kernel bottlenecks
	- Different kernel services and functionality
- What does that require from the applications?
	- Applications that are designed to scale well
	- Applications that spend a lot of the time in the kernel.
	- Popular applications.

Signs of Poor scalability: Exim
- Issue: spinlock on hash table during `sys_open`
- Solution: per-core mount cache, lock needed only in case of miss
	- Application is doing useful work while 

Per-core throughput at 48 cores, relative to 1 core
- If scales perfectly, throughput is at 1

Next Bottleneck: dentry ref counter
- Reading is slow
- Writing delays other cores.
- Writing creates huge congestion

Solution?
- Per-core padded counter array is promising, but we're dealing with a huge pre-existing codebase

Sloppy Counters
- Typically, many uses of a given counter variable in the kernel but only a few that are bottlenecks
- Goals:
	- Per-core counters for the code points where there is contention
	- Single global counter for backwards-compatability with all other code points.
- Idea: global counter "loans" some number of references to local counters to manage
	- Global counter value always >= actual count
- One local counter per core
	- Represents number of unused pre-allocated references given to that specific core
- Global counter represents total number of committed references
	- In-use or pre-allocated
- Invariant:
	- global counter = $\sum local counters$ + in-use references

Example: dcache
1. A separate eviction algorithm determines which dentry to remove
2. The dentry is marked as logically removed
	1. subsequent loop returns NULL
	2. no new loans can be issued
3. Cores eventually return any loaned refcount to the global counter
4. When the global refcount reaches 0, the dentry can be safely deleted

Assumptions
- All accesses are protected by dget/dput
	- Accesses without incrementing refcount are not allowed
	- Otherwise, RCU-style reclamation is required to avoid use-after-free

The operating system back then was the bottleneck for scalability.
We can get scalability back.

