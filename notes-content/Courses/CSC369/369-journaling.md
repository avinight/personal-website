Tags:

---

Copy on Write somewhere
[[369-advanced-vm]]

• Basic idea:
	• Write a log on disk of the operations you are about to do.
	• Example: create an empty file requires updating the following:
		• Inode Bitmap: IB
		• First inode block: I[0]
		• Root directory block: RD
journal looks like a ring buffer so it wraps around to the beginning when it is full.


• Basic idea:
	• Write a log on disk of the operation you are about to do.
		• Example: create an empty file requires updating IB, I[0], and RD
	• Write the changes to actual file system.
		• This is called checkpointing.

What goes in the "log"
 Transaction structure:
• Starts with a “transaction begin” (TxBegin) block, containing a transaction ID
• Followed by blocks with the content to be written
• Physical logging: log exact physical content
• Logical logging: log more compact logical representation
• Ends with a “transaction end” (TxEnd) block, containing the corresponding TID

For logical logging:
Idempotency: whether an operation can be performed multiple times
Figuring out what we need to do for recovery is difficult because of idempotency.
Adding a new directory entry cannot be done multiple times.
How to turn non-idempotent operations into idempotent operations

Most file systems use physical logging because it is cheap and efficient

If recovery system doesn't see the TxEnd block, then it will assume the transaction is not committed or aborted.
If recovery system does see the TxEnd block, the it will assume the transaction is committed and will try to replay the transaction.

If we crash during recovery, in a physical logging system, then idempotency is always guaranteed.


## Journaling: Recovery summary
If crash happens before the transaction is committed to the journal
- Just skip the pending update
If crash happens during the checkpoint step
-  After reboot, scan the journal and look for committed transactions
- Replay these transactions
- After replay, the FS is guaranteed to be consistent
- Called *redo logging*
	- Reapplies committed changes to restore consistency
	- More preferred; skip read from old location step
- *Undo logging*
	- Instead of storing are intentions, updated logs, store original state in the journal, read all of old states of the original locations first, put into journal, write updates to final location, commit transaction
	- not desired because of reading old locations; slightly slower
Journaling technique assumes file system code is bug free and storage device is error free.

## Journal space requirements
- It doesn't require much space, because the journal is a circular log 
- There is a bitmap inside the journal header that tracks the allocation status of each journal block for transactions, so we know which blocks are allocated, and how much free space is in the journal.
- Journal is typically 128MB in size
- If log cannot fit an operation, split operation into two or more (only happens with large data writes; rare edge case)

## Transaction batching
- Multiple operations can be grouped together into a single transaction, helping with amortization.
- Significantly reduce the cost of a transaction, instead of paying the full cost of each operation individually
- Implemented using a *page cache* 
	- If we have written to a page's in memory copy, then it is dirty
	- Everytime we make a page dirty in the page cache, then we add that page to the current transaction.
	- If page is already modified, it is already in the current transaction
- File system blocks in memory are marked dirty and added to list for current txn.
- Transaction commits on size limit, time limit, or explicit user request (fsync).
	- Writes all blocks in list to journal before writing transaction commit block

# Metadata Journaling

Metadata journaling is like journaling but we only write the metadata instead of the data as well.
What can happen now?
- Suppose we write data after checkpointing metadata
- If crash occurs before all data is written, inodes will point to garbage data!
	- This is known as *writeback mode*
- How do we avoid this?

Solution: ordered mode
- Write data BEFORE writing metadata to journal!
1. Write data, wait until it completes
2. Metadata journal write
3. Metadata journal commit
4. Checkpoint metadata
5. Free transaction
- If write data fails -> as if nothing happened
	- At least from the file system point of view!
- If write metadata fails -> same as data journaling

Data corruption can still happen. 
- If I am making updates or modifying an existing file and we crash, we will have a data inconsistency.
- Compromise between performance and reliability

fsck is not useless; journaling makes the assumption that file system has no bugs and storage device has no errors
- they can suffer bit rot/random flipping
- journaling only checks memory that has been written to, not corrupted data that hasn't been written to.
- if there is an FS bug, journaling will continue making the bug persist
# Journaling Summary
- Journaling ensures file system consistency
- Recovery complexity is in size of journal, not size of disk!
- Metadata journaling is the most commonly used
- Reduces the amount of traffic to the journal, and provides reasonable consistency guarantees at the same time.
- Widely adopted in most modern file systems (ext3, ext4, ReiserFS, JFS, XFS, NTFS, etc.)
- Is fsck useless then?




Journaling worksheet: Crash Recovery
- Crash during step 2, because of physical logging we can use idempotency and keep committing
- Crash during step 3, keep marking the transaction as free idempotentically
- Crash after step 3, nothing
- Crash during step 1, split transaction logging into 2 steps
Journaling Worksheet: Barriers
- If we remove Barrier A, then we will checkpoint garbage data to the file system. The entire blocks will become corrupt.
- If we remove Barrier B, then we will checkpoint too early when theres an invalid transaction.

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---