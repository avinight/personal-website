
Multi-level page tables reduce memory overhead
- But increase address translation cost
	- Translation cost increases with page table depth
		- N+1 memory references where N is the number of levels
	- Address translation is on the critical path of every memory access
- Hardware caches translations to make the common case fast (TLB)
- TLB lookups are very fast, but TLBs are small
	- Each TLB entry covers one page
	- TLB coverage = (number of entries) x (page size)
	- Typical TLB coverage 

TLB Coverage Trend
- TLB coverage as percentage of main memory
	- Factor of 100 decrease in 15 years
		- Main memory has grown in capacity very quick but TLB size hasn't
			- Meanwhile, TLB miss latency is increasing
				- Combined, these result in higher TLB miss overhead

Nowadays, coverage is even worse

Increase TLB size
- Difficult; TLBs are already near hardware limits
	- hardware mmu
- Add second level
	- Limited impact on coverage
	- Lower levels are slower than higher level TLBs
- Increase page size
	- Higher internal fragmentation, more memory pressure, more I/O
- Use multiple page size at the same time <= focus on this
	- Increase TLB coverage without increasing TLB size
	- Keep internal fragmentation and disk traffic low
	- SUPERPAGES!

Hardware support for Superpages
- Sizes must be power-of-two multiples of the base page size
	- MMU can determine page offset by looking at lower order bits of the address
- Must be contiguous and aligned in both virtual and physical memory
	- e.g. 4MB superpage must begin on a 4MB address boundary in both spaces
- TLB entry must include information for determining page size
- Size(s) must be supported by processor's MMU
	- Architecture with hardware-assisted TLB or software-managed TLB
		- Whatever size the TLB can support. **Why?**
			- There is no fixed page table format, the author can 
	- x86_64
		- Only 4KB, 2MB, and 1GB page sizes are supported. Why?
			- Hardware managed TLB
			- Page walk by hardware, you don't get to choose -> fixed to multilevel page table