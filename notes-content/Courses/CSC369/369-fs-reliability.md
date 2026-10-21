Tags:

---

Key reliability questions:
How do we guarantee consistency of on-disk storage?
How do we handle OS crashes and disk errors?

Consistency issues
- File system operations affect multiple metadata blocks
	- E.g., create an empty file:
		- Set a bit in inode bitmap
		- Initialize an inode structure
		- Add directory entry (may allocate another block)
- Power failure can occur between related operations
	- Disk driver can only service one request at a time, and in any order
		- Forcing synchronous operation (barrier) is way too slow
	- Can leave file system in a permanently inconsistent state
- Critical section does not help
	- We can’t force power failure to happen only when lock is released

## FS State after crash failure
If just the data block write succeeds,
- no inode, no bitmap -> as if the write did not occur
- no inconsistency
If only the inode is written to disk,
**Multiple inodes may point to the same data block** (Worst case)
- When updating a file, it will cause the other file to be updated too.
- This is called aliasing and is not allowed on ext3, other filesystems
If just the data bitmap succeeds
- Bitmap says D[3] is allocated, inode has no pointer to it
- FS inconsistent, D[3] cannot be used again
- memory/data leak: Memory is held by the system and cannot be used again for the duration of the program, it is wasted
If inode and data bitmap writes succeed:
- File system is consistent but the file contains garbage data
If inode and data block writes succeed:
- Inconsistency as inode disagrees with data bitmap
- garbage will eventually written since when data bitmap is eventually allocated, it will overwrite the original inode
If data bitmap and data block writes succeed:
- No inode points to this data block so what file does it belong to?


Crash Consistency
- Problem: Many file system operations require multiple writes to disk. If the system crashes in the middle of an operation, the file system could be in an inconsistent state.
- Questions:
	- How can we prevent these inconsistencies?
	- How can we repair the file system that is inconsistent?

File System Reliability
- Goal: Ensure that the file system metadata is in a consistent state following an operating system failure.
- Consistent state: It either looks like a file operation never happened, or it looks like the operation completed.
	- This is called failure atomicity.
- Recall that each file operation may require multiple writes to disk.

Approaches to a solution
1. Uninterruptible power supply (UPS)
	- Disable incoming file system write requests after power failure.
	- Use UPS to buy time for a clean shutdown.
	- Doesn't help if failure is due to system crash.
2. Do nothing during normal operation. Try to recover to a consistent state in the event of a crash (detect and repair).
	- Order the writes that make up an operation to minimize data loss.
	- Most older file systems used this approach (ffs, ext2).
3. Treat each file system operation as a transaction (journaling).
	- Prevent, or roll-back (undo), any changes from uncommitted transactions.
	- Replay, or roll-forward (redo), any changes from committed but incomplete transactions.
- 2, 3 are assuming correct 

Detect and Repair Solution
- When the file system comes back up, run a program to scan the file system structure and restore consistency.
- fsck - file system check
	- UNIX tool for finding inconsistencies and repairing them.
	- Similar tools exist on other systems.
- Example consistency rules (incomplete list!)
	1. All data blocks pointed to by inodes (and indirect blocks) must be marked allocated in the data bitmap
	2. No allocated data block can be pointed to more than once. (ext2 only)
	3. All allocated inodes must be in some directory entry.
	4. Inode link count must match number of directory entries.

What does fsck check? Do the least amount of damage
1. Superblock: sanity checks
2. Free blocks: scan inodes (including all indirect blocks), build in-memory bitmap
3. Inode state: check inode fields for possible corruption

minimal damage inflicted to the file system^. Some data loss will happen to blocks

we don't allow hard links to directories, it would make the file system tree into a graph. Directories could have more than one parent, and it could create loops during path traversal.

Check all names are unique for all directories
fsck doesn't know what you accessed or didn't accessed. 

Journaling is a better solution.
Journal = 128MB default
journal must be contiguous on disk, so we can get maximum throughput to the journal.



<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---