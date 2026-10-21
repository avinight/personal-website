---
tags:
  - course/csc367
  - computer-science
---

Parallelization cannot compensate for poor single core performance

## Compiler Optimizations
Compiler performs a number of optimizations:
- Improve register reuse, can reorder instructions to optimize this
- Interchanges loops (reorder)
- Unrolls loops
- Fuse loops (merge two together)
- Eliminate dead code (the branch never taken)
- Strength reduction (turns expensive instruction, e.g., multiply by 2, into cheaper one, shift left)

How to know if the compiler has optimized your code?
- Profile!
- Check the assembly code!

Why not just leave the compiler to optimize all our code?
- Compilers often give up on optimizing complex code: 
	- To preserve correctness
- A compiler applies optimizations with some general policies:
	- Sometimes you can outsmart a compiler even on simple code because you know the specifics of your code!

Memory Hierarchy
- SRAM (Second level cache)
- DRAM (Main Memory)
- Disk (Secondary Storage)
- Tape/Cloud (Tertiary Storage)

Latency: The time it takes to go from one point to another.
- For example the memory access latency can be 100 ns which means it will take 100ns to retrieve one byte/word from memory.

Bandwidth: The amount of data transferred in a fixed period of time.
- For example the memory bandwidth can be 100MB/s.

Caches: Reads and writes from main memory are in contiguous blocks, i.e. cache lines
- Caches store previously accessed cache lines to hopefully reduce references to memory!
- If the data required by the processor resides in cache we get a cache hit, fast!
- Data accesses that are not in the cache lead to a cache miss, slow!

Temporal locality: Reuse data that is already in cache.
- Eliminate memory operations by saving values in small, fast memory (cache or registers) and reusing them (bandwidth filtering).

Spatial locality: Operate on data that are stored close to each other in memory and can be brought into cache together.
- Take advantage of better bandwidth by getting a chunk of memory into cache (or registers) and using the whole chunk.

Cache prefetching
- Requesting data from memory (manually or automatically) ahead of its use.

# Matrix Multiplication revisited

- Each element is a double and is 8 Bytes
- The matrix is 4K by 4K: How many elements does a row have?
	- 4 x 1024 = 4096 elements
- Cache line size is 64B: How many elements can fit in a cache line?
	- 64B / 8B = 8 elements
- The Cache is 256KB: How many rows can the cache store?
	- 4096 elements x 8B = 32K Bytes per row
	- 256 KB / 32KB = 8 rows
	
- The cache stores 32K elements at a time.
- If each memory reference gave us 8 consecutive elements, how many memory references are needed to complete the 8K floating point operations? 
	- Might depend on the cache eviction policy but at best 512 (for C), 1 (for A), 512 (for B). Improved spatial locality!
	- Are we also taking advantage of temporal locality?
		- Yes, by reusing the element in A.

Cold Cache: When the data in the cache is stale: Need to read from memory!
Warm cache: when relevant data is in the cache.

If you run a code once vs if you run a code 10 times and average over those runs, timings might differ because of the cold cache concept!

False sharing: The cache line is bounced between processors because x and y are in the same cache line and because caches have to be coherent! 

Pipelining:
- helps bandwidth not latency
- Bandwidth is limited by slowest pipeline stage

SIMD: Single Instruction Multiple Data
- Scalar processing
	- traditional mode
	- one operation produces one result

SSE / SSE2 SIMD on Intel
- SSE2 data types: anything that fits into 6 bytes, e.g.
	- 4x floats
	- 2x doubles
	- 16x bytes
- Instructions perform add, multiply etc. on all the data in this 16-byte register in parallel
- Challenges:
	- Need to be contiguous in memory and aligned
	- Some instructions to move data around from one part of register to another
- Similar on GPUs, vector processors (but many more simultaneous operations)