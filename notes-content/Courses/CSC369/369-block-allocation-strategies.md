Of the three allocation strategies we talked about in class, which requires the least amount of meta data to store information about which blocks belong to a file?
Contiguous - We only need to store the starting block and the length of the file.

Which strategy would be slowest for random access?  (Random access is a read request that says, "I would like to read byte X of the file")
Linked - We need to read each block of the file to get the pointer to the next block until we reach the block containing byte X.

Which strategy (or strategies) would be the best for writing to the end of the file if the write caused a new block to be needed?
Linked Allocation
- If we keep a link to the last block of the file, this strategy works well.
Indexed Allocation
- The inode stores the size of the file, so we know which pointer points to the last block of the file, and can allocate the next pointer.

How many disk accesses are potentially required to read the Nth block of a file that is N blocks long where N is very large?

| Contiguous allocation | 1   | We can compute which block is the Nth block of the file, and directly read it.                                                                                                                                  |
| --------------------- | --- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Linked Allocation     | N   | We need to read each block to get the pointer to the next.                                                                                                                                                      |
| Indexed Allocation    | 4   | If N is large enough to require the triple indirect block, then we need to read the triple indirect block, the corresponding double indirect block, the corresponding single indirect block and the data block. |
