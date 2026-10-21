> [!question] 
> Explain the term memory hierarchy. What are the differences between primary, secondary, and tertiary storage? Give examples of each. Which of these is volatile, and which are persistent? Why is persistent storage more important for a DBMS than, say, a program that generates prime numbers? (Section 9.1)

Memory hierarchy is how system in which data is accessed. Primary storage are for quick data retrieval such as cache and main memory, these are usually volatile and expensive because of their need to be robust under heavy load. Secondary storage are devices where long term data is stored like disks. Tertiary devices. both are non-volatile, persistent storage solutions for massive data collections like DBMS.

> [!question] 
> Why are disks used so widely in a DBMS? What are their advantages over main memory and tapes? What are their relative disadvantages? (Section 9.1.1)

Disks provide seamless access to data in a DBMS. Advantages are that main memory is expensive for long term and large storage of data. Main memory is also volatile storage. Tapes must be read sequentially adding additional overhead to reading and writing each time. Disks provide seamless read and write capabilities since they can access different parts of the disk efficiently. Disadvantages include mechanical failure, access time = seek time + transfer time + rotational delay, more expensive than tapes, slower than main memory.

> [!question] 
> What is a disk block or page? How are blocks arranged in a disk? How does this affect the time to access a block? Discuss seek time, rotational delay, and transfer time. (Section 9.1.1)

access time = seek time + transfer time + rotational delay. Data is stored in units called disk blocks. Blocks are arranged on concentric rings called tracks on a disk. This affects the access time since we first must look for the track that contains the block (seek time), then the disk head must look for the block along the ring (rotational delay), then either read or write to the block which is transfer time.

> [!question] 
> Explain how careful placement of pages on the disk to exploit the geometry of a disk can 
> minimize the seek time and rotational delay when pages are read sequentially. (Section 9.1.2)

if two records are frequently used together, we should place them close together. The ‘closest’
that two records can be on a disk is to be on the same block. In decreasing order of closeness, they could be on the same track, the same cylinder, or an adjacent cylinder.

Careful placement of pages on disk reduces seek and rotational overheads. By storing sequential pages contiguously on the same track and across adjacent tracks of a cylinder, and aligning them rotationally so the next page arrives just as the head is ready, a DBMS minimizes head movement and waiting. This allows sequential reads to approach the raw transfer speed of the disk.

> [!question] 
> Explain what a RAID system is and how it improves performance and reliability. Discuss striping and its impact on performance and redundancy and its impact on reliability. What are the tradeoffs between reliability and performance in the different RAID organizations called RAID levels? (Section 9.2)

If the disk array consists of D disks, then partition i is written onto disk i mod D.

A RAID system uses multiple disks to improve DBMS performance and reliability. **Striping** distributes data across disks, increasing performance through parallel I/O, but provides no reliability on its own. **Redundancy** (mirroring or parity) improves fault tolerance, allowing recovery from disk failures. RAID 0 offers maximum performance but no reliability; RAID 1 provides high reliability at double the storage cost; RAID 5/6 balance performance and redundancy by using distributed parity, tolerating one or two disk failures at lower storage overhead. The tradeoff is that more redundancy improves reliability but reduces usable capacity and may slow writes.

>[!question] 
>What is the role of the DBMS disk space manager? Why do database systems not rely on the operating system instead? (Section 9.3)

It manages space on the disk.  One practical reason is that a DBMS vendor who wishes to support several OS platforms cannot assume features specific to any OS, for portability, and would therefore try to make the DBMS code as self-contained as possible

A technical reason is that on a 32-bit system, the largest file size is 4 GB, whereas a DBMS may want to access a single file larger than that. A related problem is that typical OS files cannot span disk devices, which is often desirable or even necessary in a DBMS.

> [!question] 
> Why does every page request in a DBMS go through the buffer manager? What is the buffer pool? What is the difference between a frame in a buffer pool, a page in a file, and a block on a disk? (Section 9.4)

Every page request goes through the buffer manager because it decides whether the page can be served from memory or must be fetched from disk, ensuring efficient access and consistency. The buffer pool is the region of main memory managed by the buffer manager, consisting of frames that hold database pages. A **page** is a logical unit of data in a database file, a **block** is the physical unit of I/O on disk, and a **frame** is an in-memory slot in the buffer pool that stores a page.


> [!question] 
> What information does the buffer manager maintain for each page in the buffer pool? What information is maintained for each frame? What is the significance of pin count and the dirty flag for a page? Under what conditions can a page in the pool be replaced? Under what conditions must a replaced page be written back to disk? (Section 9.4)

The buffer manager maintains, for each page in the buffer pool, its page ID, pin count, dirty flag, and replacement policy info. For each frame, it tracks occupancy, the page it holds, and associated metadata. The **pin count** indicates how many transactions are using a page, preventing replacement if > 0. The **dirty flag** signals if a page has been modified and must be written back before eviction. A page can only be replaced when its pin count is zero, and must be written to disk if it is dirty.

> [!question] 
> Why does the buffer manager have to replace pages in the buffer pool? How is a page chosen for replacement? What is sequential flooding, and what replacement policy causes it? (Section 9.4.1)



> [!question] 
> A DBMS buffer manager can often predict the access pattern for disk pages. How does it utilize this ability to minimize I/O costs? Discuss prefetching. What is forcing, and why is it required to support the write-ahead log protocol in a DBMS? In light of these points, explain why database systems reimplement many services provided by operating systems. (Section 9.4.2)



> [!question] 
> Why is the abstraction of a file of records important? How is the software in a DBMS layered to take advantage of this? (Section 9.5) What is a heap file? How are pages organized in a heap file? Discuss list versus directory organizations. (Section 9.5.1)



> [!question] 
> Describe how records are arranged on a page. What is a slot, and how are slots used to identify records? How do slots enable us to move records on a page without altering the record’s identifier? What are the differences in page organizations for fixed-length and variable-length records? (Section 9.6)



> [!question] 
> What are the differences in how fields are arranged within fixed-length and variable-length records? For variable-length records, explain how the array of offsets organization provides direct access to a specific field and supports null values. (Section 9.7)


# Exercises
