Tags:

---

Cylinder groups
- probably don't want to put the root dir in the same cylinder group; everything in the entire file system
- Each user's home directory should have their own cylinder group

$$\text{number of blocks} \times \text{block size} = \text{file size}$$

More FFS solutions:
Problem: Small blocks (1K) in original Unix FS
- Low bandwidth utilization, small max file size (function of block size)
- Fix: increase the block size (4K)
	- Allows very large files
		- Only need two levels of indirection for files up to 2^32 = 4GB in size.
	- New Problem: internal fragmentation
		- Fix: Introduce “fragments” (1K pieces of a block), also known as *tail packing*
		- Tail packing is not used anymore because
			- tail packing reduces performance
Problem: Media failures
- Fix: Replicate master block (superblock)
Problem: Device oblivious
- Fix: Parameterize FS according to device characteristics

FAT uses linked based allocation
NTFS uses extent based allocation

runs is microsoft term, extent is linux term

Inline data - data content is embedded in the inode structure itself
1 seek of inode structure to get data; great for small files

The more duplicate information you have in the file system, the harder it is to keep the file system consistent.



<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---