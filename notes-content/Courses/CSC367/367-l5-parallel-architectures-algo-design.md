---
tags:
  - course/csc367
  - computer-science
---

# Objective
---

Given a procedure, how can we make it fast?
- What is our hardware?
- How can we map the procedure to the hardware?

What is the difference between these two procedures?

Matrix Vector Multiplication
- You can parallelize

Triangular Solve
- Data dependency

Where is the memory physically located?
Is it connected directly to processors?
What is the connectivity of the network?

Parallel Machine models
- Shared Memory: Pthreads, OpenMP, etc.
- Distributed Memory: MPI
- SIMD and Vector: CUDA
- Hybrid: A mix of the above

Parallel Algorithm Design
- General Guidelines
	- Identify tasks in your program that can be performed concurrently
	- Map concurrent tasks onto multiple threads or processes, to be run in parallel
	- Partition the input, output, and/or intermediate data and assign to processes
	- Handle concurrent accesses to shared data by multiple processes
	- Add synchronization between stages of the parallel execution, where necessary
	- Keep in mind the underlying parallel architecture, its advantages and limitations
	- Profile performance and determine what the bottlenecks are
	- Target optimizations based on profiling information and performance analysis
	- Write benchmarks to test your program in a variety of configurations

Task: unit of computation that can be extracted from the main program and assigned to a process, and which can be run concurrently

Decomposition: dividing the computation in a program into tasks that could be executed in parallel.

The way to extract tasks and the mapping to processes affects performance

Tasks can range from individual instructions to entire programs

Which one is better? Every instruction is a task or Every program is itself a task?
- The answer is always "it depends" .. on the specific application and the parallel platform.
first one
couple cpu processes second one is better

# Task dependencies
---
- Tasks are not independent if they have dependencies on other tasks
- A task might need data produced by other tasks => must wait until input is ready
- Dependencies create an ordering of task execution => task dependency graph
	- DAG: tasks as nodes, dependencies as edges
	- "Start nodes" = no incoming edges; "Finish nodes" = no outgoing edges

Granularity of Decomposition
- How can we define a good task dependency graph?
	- We need to decide how many tasks to create (i.e. the task granularity)
	- We need to determine how many tasks can run in parallel (i.e. the available concurrency)
- Granularity: determined by how many tasks and what their sizes are
	- Coarse-grained: a small number of large tasks
	- Fine-grained: a large number of small tasks
- Concurrency: determined by the available parallelism in the workload.
	- Maximum degree of concurrency: the maximum number of tasks that can run in parallel at any point in time.
	- Average degree of concurrency: the average number of tasks that can be executed concurrently over the entire execution

Parallelism and granularity:
- Communication between tasks may or may not be necessary
- Ideal parallelism: no communication needed
- Coarse-grained parallelism: Lots of computation performed before communication is necessary
	- Good match for message-passing environments (MPI)
- Fine-grained parallelism: Frequent communication may be necessary
	- More suitable for shared memory environments (PThreads, OpenMP)
- Parallelism granularity = how much processing is performed before communication is necessary between processes

Degree of concurrency
- Maximum degree of concurrency = max number of tasks that can be executed simultaneously at any given time
	- Typically, less than total number of tasks, if tasks have dependencies
- Average degree of concurrency = average number of tasks that can be executed concurrently, during the program's execution

Critical path = the longest path between any pair of start and finish nodes
Critical path length = sum of node weights along the critical path

Average degree of concurrency = total amount of work / critical path length
Shorter critical path => higher degree of concurrency

If granularity of decomposition is more fine-grained, more concurrency available
More concurrency => more potential tasks to run in parallel
If so, then reduce program execution time by just increasing granularity of tasks?
- Not quite true
	- Inherent limits to fine-grained decomposition, e.g. hitting indivisible tasks, or tasks which cause slowdown if split up
	- For example, if a task multiplies one element of A with one element of b to store a partial value of one element of c then all tasks working on the first row of A have to interact
	- More tasks => potentially more dependencies => more overhead

# Task interactions
---
- A task dependency graph only captures producer-consumer interactions
	- A task's output is used as another task's input
- Interactions might occur among tasks that are independent in the task dependency graph
	- Tasks on different processors might need to exchange data or synchronize
	- e.g. if each task stores one item from b, must exchange their data to get all of b.
- Tasks may share data via task interactions
	- Read-only interactions: tasks only need to read data shared with other tasks
	- Read-write interactions: tasks can read or write data shared with other tasks
	- Think of the kind of interactions found in the following problem, when solved in parallel:
		- matrix-vector multiplication
- Type of sharing can affect which tasks should get mapped to which processes
	- Read-write interactions should be kept on the same process as much as possible

Mapping tasks to processes
- Mapping = Assigning tasks to processes 
- The choice of decomposition affects the ability to select a good mapping
- Goals of a good mapping:
	- Maximize the use of concurrency
	- Minimize the total completion time
	- Minimize interaction among processes
- Often, the task decomposition and mapping can result in conflicting goals 
	- Must find a good balance to optimize for all goals
- Degree on concurrency is affected by decomposition choice, but the mapping affects how much of the concurrency can be efficiently utilized

Map the tasks to processes, in each of the two situations
Key questions: How many processes can be used? how effectively are you using them and why?

Task size and balance
- Task size = proportional to time needed to complete the task
	- Uniform tasks: require roughly the same amount of time
	- Non-uniform tasks: execution times vary widely
- Size of data associated with tasks = how much data does each task process?
	- Impacts whether the tasks are well-balanced
	- Affects performance if a task's data must be moved from a remote processor
	- Input data might be small, but output data is large, or vice-versa, etc

False sharing: 
False Sharing with read-write sharing in a cache line

# Decomposition techniques
---

Recursive decomposition
- Dividing pieces fit in the cache, fast computation
Data decomposition
- Split the data into chunks and these chunks guide the task decomposition (data-first)

- Recursive decomposition is primarily based on task decomposition
- Useful for problems that can be approached using a divide-and-conquer strategy
- Divide problem into subproblems, solve subproblems by subdividing recursively the same way and combining results
- Subproblems can be solved concurrently

