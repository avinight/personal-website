Tags:

---

Paged virtual memory
Paged address translation
Page table entry format
Better page table designs
Page table entries

Space overhead

number of offset bits = log_2(pagesize)

Paging limitations
Possibility - bigger pages
Managing page tables
Dynamically extend page table?
Page table per logical segment?

Managing Segmented page tables
Requirements for table-per-segment scheme
- Page table base register per segment
- Page table limit register per segment
- Inflexible
- Limits number of regions
- Can still end up with lots of page table waste
- e.g., if we have a large but sparse heap
- External fragmentation
- Page tables can be of arbitrary size and requires contiguity.
- Finding free space for page tables in memory gets complicated

Hierarchical page table


Two level page tables

64 bit address spaces

Hashed page tables

Inverted page tables
Keep one table with an entry for each physical page frame
- Entries record which virtual page # is stored in that frame
- Need to record process id as well
- Less space, but lookups are slower
- References use virtual addresses, table is indexed by physical addresses
- Use hashing to reduce the search time
- Core map
- Similar structure, but keeps track of state of physical frames, e.g., free or used
- Enables fast allocation of physical frame
- Not used for address translation
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---