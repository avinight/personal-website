---
tags:
  - course/csc443
  - computer-science
---
In this project, you will build a key-value store from scratch. A key-value store (KV-store) is a kind of database system that stores key-value pairs and allows retrieval of a value based on its key. KV-stores exhibit the following simple API:

Open(“database name”) opens your database and prepares it to run
Put(key, value)               stores a key associated with a value
Value = Get(key)             retrieves a value associated with a given key
KV-pairs= Scan(Key1, Key2)  retrieves all KV-pairs in a key range in key order (key1 < key2)
Close() closes your database

This API also reflects common data structures you have likely seen before (e.g., binary trees). Unlike simple binary trees, however, your KV-store must be able to store data greater than the amount of memory your system has available. In other words, it will have to spill data to storage (disk or SSD) as the size of the data grows.

You will implement this key-value store using various data structures that we will cover in class. Specifically, you will implement an LSM-tree in storage complemented by in-memory filters. This architecture follows that of many popular modern KV-stores, including RocksDB, Cassandra, HBase, etc.

Step 1 – Creating a Memtable and SSTs

- Create a ZipTree Memtable that complies with the API
	- Create a class to represent the nodes in your tree
- Memtable should take a parameter called `memtable_size`
- When we hit `memtable_size`, implement a traversal of the memtable based on the order of keys, and output all the key-value pairs to a sorted file, which you will save in your storage device. You can employ the same code as your scan operator to perform this traversal. 
	- You will need to investigate and employ C++/Rust libraries to perform an efficient sequential write to a file.
	
- Once the file is created and stored in storage, you will need to allocate a new memtable to be able to ingest more data. When this newer memtable fills up, you will again transform it into a sorted file using the same workflow as above. We will refer to these files from now on as SSTs

- (Sorted String Tables). This is how real systems like RocksDB refer to them, so we may as well use terminology from the real world. The SSTs should be assigned unique names. 


- Your get method should search both the memtable and all SSTs in the order of youngest to oldest. It should return the first value with a matching key that it finds. To do this, you will need to implement a binary search over each SST. Please investigate the pread linux commands to only read one page of an SST for each hop of your binary search. 

- Your scan method should also search the memtable and the SSTs. To search the SSTs, you can use a binary search to find the start of the range and continue with a scan until you encounter a key outside of the range. Note that the scan command is more complex to implement than the put or get commands because it is not known in advance how many key-value pairs are in the target range. Therefore, this command should return a pointer to an array of results, along with the size of this array. 

  

- The Open command in the API should create a directory with the name of the database you are creating and store all SSTs and other data relating to your database within this directory. 
- If the open command is called with the name of an existing directory, it should prepare that database for operation. 

- The close command should transform whatever is in the current Memtable into an SST and gracefully shut down the database without losing any data in memory. 
- When you subsequently open the same database, all data that had previously been inserted should still be available. 

For now, let’s focus on only inserting unique keys into the tree (i.e., insertions). We will later learn how to also handle updates when we learn about LSM-trees.

This step of the project can be further decomposed into mini-steps, which you can assign to each of the three members of your group.

1. Implement the memtable as a balanced binary tree that supports put and get. 
2. Implement scans over the memtable, and use this mechanism to transform the memtable into an SST when it reaches capacity.
3. Extend your get and scan functionalities to search the memtable and all SSTs with binary search. 

  
Optional: We encourage you to generate experiments that measure the performance of your three operators, put, get and scan, as you insert more data into the system. The reason is that to check early on that performance is as you would expect. However, the experiments for this step are not mandatory in your hand-in, as the experiments you will later perform in Step 3 supersede them. For the optional experiments in this step, the x-axis should report the data volume that had been inserted, while the y-axes should report throughput. Three figures should be produced, one for each operation. These should be included in your report under the title “Experiments for Step 1”. Bandwidth can be measured by dividing time into consecutive windows (e.g., 10 seconds each), recording how many operations were performed in each window, and diving by the window length in seconds to get the average number of operations per second.


Experiments for step 2
- Compare binary search to b-tree search (query throughput vs data size)
- Uniformly randomly distributed point queries and data
- Enable the buffer pool
- Explain findings

Experiments for step 3
- Measure insertion, get, and scan throughput for your implementation over time as the data size grows. 
- Describe your experimental setup and make sure all relevant variables are controlled. Please fix the buffer pool size to 10 MB, the filters to use 8 bits per entry, and the memtable to 1 MB. 
- Run this experiment as you insert 1 GB of data. 
- Measure get and scan throughput at regular intervals as you insert this data. 
- If you did any of the bonus tasks, please make sure to report how they are used in the experiment.


Report

List of report must-haves

1. Description of design elements - concisely describe the different elements of your design (i.e., memtable, B-tree creation, buffer pool, etc), and any interesting design decision you have made. This should correspond to the list of design elements below. Feel free to tell us about extra cool stuff you might have added. Please also tell us where to find the implementation of each design element in the code (i.e., file and function name). (2 points)
2. Project status - Give details on what works and what does not. If there are known bugs in your code, list them here. (2 points)
3. Experiments - please show experimental figures and explain your findings for each experiment. If you have some extra experiments that you did, put them here under a separate “Extra Experiments” heading. (2 points)
4. Testing - Testing is a very important part of any implementation, Mention how you tested your implementation, if you have several unit and integration tests, list them here. (2 points)
5. Compilation & running Instructions - detail out how to run your project (i.e., give makefile targets and describe what they are for). If you have an executable that we can use to run simple commands, give instructions on how to use that. (2 points)




# LSM Tree needs
- Add timestamps for tombstone support

```zig
test "Compaction triggers on memtable flush" {
const allocator = std.testing.allocator;

  

const test_dir = "test_compaction_trigger";

std.fs.cwd().deleteTree(test_dir) catch {};

try std.fs.cwd().makeDir(test_dir);

defer std.fs.cwd().deleteTree(test_dir) catch {};

  

var kvstore = try KVStore.init(allocator);

defer kvstore.close();

try kvstore.open(test_dir);

  

// Insert enough data to trigger multiple memtable flushes

// Use a smaller count for testing (1000 entries per flush)

const entries_per_test = 1000;

  

// First batch

var i: u64 = 0;

while (i < entries_per_test) : (i += 1) {

try kvstore.put(i, i * 10);

}

// Force flush

if (kvstore.memtable.size > 0) {

try kvstore.flushMemtable();

}

  

// Second batch - should trigger compaction

while (i < entries_per_test * 2) : (i += 1) {

try kvstore.put(i, i * 10);

}

// Force flush

if (kvstore.memtable.size > 0) {

try kvstore.flushMemtable();

}

  

// Verify all keys are readable after compaction

var j: u64 = 0;

while (j < entries_per_test * 2) : (j += 1) {

const value = try kvstore.get(j);

try std.testing.expectEqual(@as(?u64, j * 10), value);

}

  

// Verify level structure: level 0 should be empty or have 1 table, level 1 should have data

try std.testing.expect(kvstore.levels.items.len >= 1);

if (kvstore.levels.items.len > 0) {

// Level 0 should have at most 1 SSTable after compaction

try std.testing.expect(kvstore.levels.items[0].items.len <= 1);

}

}

  

test "Compaction merges overlapping keys correctly" {

const allocator = std.testing.allocator;

  

const test_dir = "test_compaction_overlap";

std.fs.cwd().deleteTree(test_dir) catch {};

try std.fs.cwd().makeDir(test_dir);

defer std.fs.cwd().deleteTree(test_dir) catch {};

  

var kvstore = try KVStore.init(allocator);

defer kvstore.close();

try kvstore.open(test_dir);

  

// Insert keys 1-1000 with value = key

var i: u64 = 1;

while (i <= 1000) : (i += 1) {

try kvstore.put(i, i);

}

  

// Force flush

if (kvstore.memtable.size > 0) {

try kvstore.flushMemtable();

}

  

// Update keys 500-1500 with value = key * 2 (overlapping range)

i = 500;

while (i <= 1500) : (i += 1) {

try kvstore.put(i, i * 2);

}

  

// Force flush - should trigger compaction

if (kvstore.memtable.size > 0) {

try kvstore.flushMemtable();

}

  

// Verify keys 1-499 have original values

i = 1;

while (i < 500) : (i += 1) {

const value = try kvstore.get(i);

try std.testing.expectEqual(@as(?u64, i), value);

}

  

// Verify keys 500-1000 have updated values (newer should win)

i = 500;

while (i <= 1000) : (i += 1) {

const value = try kvstore.get(i);

try std.testing.expectEqual(@as(?u64, i * 2), value);

}

  

// Verify keys 1001-1500 have their values

i = 1001;

while (i <= 1500) : (i += 1) {

const value = try kvstore.get(i);

try std.testing.expectEqual(@as(?u64, i * 2), value);

}

}

  

test "Compaction preserves order and completeness" {

const allocator = std.testing.allocator;

  

const test_dir = "test_compaction_order";

std.fs.cwd().deleteTree(test_dir) catch {};

try std.fs.cwd().makeDir(test_dir);

defer std.fs.cwd().deleteTree(test_dir) catch {};

  

var kvstore = try KVStore.init(allocator);

defer kvstore.close();

try kvstore.open(test_dir);

  

// Insert keys in non-sequential order across multiple flushes

const keys = [_]u64{ 100, 50, 150, 25, 75, 125, 175, 10, 200 };

  

for (keys, 0..) |key, idx| {

try kvstore.put(key, key * 3);

// Force flush every 3 keys to create multiple SSTables

if ((idx + 1) % 3 == 0) {

if (kvstore.memtable.size > 0) {

try kvstore.flushMemtable();

}

}

}

  

// Force final flush

if (kvstore.memtable.size > 0) {

try kvstore.flushMemtable();

}

  

// Verify all keys are present with correct values

for (keys) |key| {

const value = try kvstore.get(key);

try std.testing.expectEqual(@as(?u64, key * 3), value);

}

  

// Verify scan returns keys in sorted order

const ScanTest = struct {

keys: std.ArrayList(u64),

values: std.ArrayList(u64),

allocator: std.mem.Allocator,

  

pub fn scan(self: *@This(), key: u64, value: u64) void {

self.keys.append(self.allocator, key) catch unreachable;

self.values.append(self.allocator, value) catch unreachable;

}

};

  

var scan_test = ScanTest{

.keys = try std.ArrayList(u64).initCapacity(allocator, 0),

.values = try std.ArrayList(u64).initCapacity(allocator, 0),

.allocator = allocator,

};

defer scan_test.keys.deinit(allocator);

defer scan_test.values.deinit(allocator);

  

try kvstore.scan(0, std.math.maxInt(u64), &scan_test);

  

// Verify keys are in sorted order

var i: usize = 1;

while (i < scan_test.keys.items.len) : (i += 1) {

try std.testing.expect(scan_test.keys.items[i - 1] < scan_test.keys.items[i]);

}

  

// Verify all expected keys are present

try std.testing.expectEqual(keys.len, scan_test.keys.items.len);

}

  

test "Compaction cascades through multiple levels" {

const allocator = std.testing.allocator;

  

const test_dir = "test_compaction_cascade";

std.fs.cwd().deleteTree(test_dir) catch {};

try std.fs.cwd().makeDir(test_dir);

defer std.fs.cwd().deleteTree(test_dir) catch {};

  

var kvstore = try KVStore.init(allocator);

defer kvstore.close();

try kvstore.open(test_dir);

  

// Create enough SSTables to force cascading compaction

// Use smaller batches for testing

const flushes = 6;

const entries_per_flush = 300;

  

var flush_num: usize = 0;

while (flush_num < flushes) : (flush_num += 1) {

var i: u64 = 0;

while (i < entries_per_flush) : (i += 1) {

const key = flush_num * entries_per_flush + i;

try kvstore.put(key, key * 7);

}

// Force flush after each batch

if (kvstore.memtable.size > 0) {

try kvstore.flushMemtable();

}

}

  

// Verify the level structure reflects cascading

// After 6 flushes with ratio 2, we should have multiple levels

try std.testing.expect(kvstore.levels.items.len >= 1);

  

// Verify all data is still accessible

flush_num = 0;

while (flush_num < flushes) : (flush_num += 1) {

var i: u64 = 0;

while (i < entries_per_flush) : (i += 1) {

const key = flush_num * entries_per_flush + i;

const value = try kvstore.get(key);

try std.testing.expectEqual(@as(?u64, key * 7), value);

}

}

}

  

test "Compaction with tombstones removes deleted keys" {

const allocator = std.testing.allocator;

  

const test_dir = "test_compaction_tombstones";

std.fs.cwd().deleteTree(test_dir) catch {};

try std.fs.cwd().makeDir(test_dir);

defer std.fs.cwd().deleteTree(test_dir) catch {};

  

var kvstore = try KVStore.init(allocator);

defer kvstore.close();

try kvstore.open(test_dir);

  

// Insert initial data

var i: u64 = 1;

while (i <= 100) : (i += 1) {

try kvstore.put(i, i * 5);

}

  

if (kvstore.memtable.size > 0) {

try kvstore.flushMemtable();

}

  

// For now, we can't easily test actual deletion since del() isn't implemented

// But we can verify that the compaction infrastructure is in place

  

// Insert more data to trigger compaction

i = 101;

while (i <= 200) : (i += 1) {

try kvstore.put(i, i * 5);

}

  

if (kvstore.memtable.size > 0) {

try kvstore.flushMemtable();

}

  

// Verify all keys are still accessible after compaction

i = 1;

while (i <= 200) : (i += 1) {

const value = try kvstore.get(i);

try std.testing.expectEqual(@as(?u64, i * 5), value);

}

  

// Scan should return all non-tombstoned entries in order

const CountScanner = struct {

count_ptr: *usize,

  

pub fn scan(self: *@This(), key: u64, value: u64) void {

_ = key;

_ = value;

self.count_ptr.* += 1;

}

};

var count: usize = 0;

var scanner1 = CountScanner{ .count_ptr = &count };

try kvstore.scan(1, 200, &scanner1);

  

try std.testing.expectEqual(@as(usize, 200), count);

}

  

test "Reopening database preserves compacted state" {

const allocator = std.testing.allocator;

  

const test_dir = "test_reopen_compacted";

std.fs.cwd().deleteTree(test_dir) catch {};

try std.fs.cwd().makeDir(test_dir);

defer std.fs.cwd().deleteTree(test_dir) catch {};

  

// First session: create and compact data

{

var kvstore = try KVStore.init(allocator);

defer kvstore.close();

try kvstore.open(test_dir);

  

var i: u64 = 1;

while (i <= 500) : (i += 1) {

try kvstore.put(i, i * 11);

}

  

// Force flushes to trigger compaction

if (kvstore.memtable.size > 0) {

try kvstore.flushMemtable();

}

  

i = 501;

while (i <= 1000) : (i += 1) {

try kvstore.put(i, i * 11);

}

  

if (kvstore.memtable.size > 0) {

try kvstore.flushMemtable();

}

  

// Verify compaction happened

try std.testing.expect(kvstore.levels.items.len > 0);

}

  

// Second session: reopen and verify

{

var kvstore = try KVStore.init(allocator);

defer kvstore.close();

try kvstore.open(test_dir);

  

// Verify all data is still accessible

var i: u64 = 1;

while (i <= 1000) : (i += 1) {

const value = try kvstore.get(i);

try std.testing.expectEqual(@as(?u64, i * 11), value);

}

  

// Verify scan works correctly

const CountScanner2 = struct {

count_ptr: *usize,

  

pub fn scan(self: *@This(), key: u64, value: u64) void {

_ = key;

_ = value;

self.count_ptr.* += 1;

}

};

var count: usize = 0;

var scanner2 = CountScanner2{ .count_ptr = &count };

try kvstore.scan(1, 1000, &scanner2);

  

try std.testing.expectEqual(@as(usize, 1000), count);

}

}

  

test "Get returns newest across SSTables" {

const allocator = std.testing.allocator;

  

const test_dir = "test_get_newest";

std.fs.cwd().deleteTree(test_dir) catch {};

try std.fs.cwd().makeDir(test_dir);

defer std.fs.cwd().deleteTree(test_dir) catch {};

  

var kvstore = try KVStore.init(allocator);

defer kvstore.close();

try kvstore.open(test_dir);

  

// Old version -> flush to SSTable 0

try kvstore.put(42, 100);

try kvstore.flushMemtable();

  

// New version -> flush to SSTable 1

try kvstore.put(42, 200);

try kvstore.flushMemtable();

  

// Newest should win (either due to compaction or recency)

const v = try kvstore.get(42);

try std.testing.expectEqual(@as(?u64, 200), v);

}

  

test "Scan returns newest across memtable and SSTables and deduplicates" {

const allocator = std.testing.allocator;

  

const test_dir = "test_scan_newest";

std.fs.cwd().deleteTree(test_dir) catch {};

try std.fs.cwd().makeDir(test_dir);

defer std.fs.cwd().deleteTree(test_dir) catch {};

  

var kvstore = try KVStore.init(allocator);

defer kvstore.close();

try kvstore.open(test_dir);

  

// SSTable 0: keys 1..5 value=10x

{

var k: u64 = 1;

while (k <= 5) : (k += 1) try kvstore.put(k, k * 10);

try kvstore.flushMemtable();

}

// SSTable 1: update keys 3..7 value=100x

{

var k: u64 = 3;

while (k <= 7) : (k += 1) try kvstore.put(k, k * 100);

try kvstore.flushMemtable();

}

// Memtable (newest, not flushed): update keys 5..9 value=1000x

{

var k: u64 = 5;

while (k <= 9) : (k += 1) try kvstore.put(k, k * 1000);

}

  

const Collector = struct {

keys: std.ArrayList(u64),

values: std.ArrayList(u64),

allocator: std.mem.Allocator,

pub fn scan(self: *@This(), key: u64, value: u64) void {

self.keys.append(self.allocator, key) catch unreachable;

self.values.append(self.allocator, value) catch unreachable;

}

};

  

var col = Collector{

.keys = try std.ArrayList(u64).initCapacity(allocator, 0),

.values = try std.ArrayList(u64).initCapacity(allocator, 0),

.allocator = allocator,

};

defer col.keys.deinit(allocator);

defer col.values.deinit(allocator);

  

try kvstore.scan(1, 9, &col);

  

// Expect exactly keys 1..9, each once, newest value per key

try std.testing.expectEqual(@as(usize, 9), col.keys.items.len);

var i_scan: usize = 0;

while (i_scan < col.keys.items.len) : (i_scan += 1) {

const k = col.keys.items[i_scan];

const v2 = col.values.items[i_scan];

// Sorted order

if (i_scan > 0) try std.testing.expect(col.keys.items[i_scan - 1] < k);

// Value from newest source:

// 1..2 -> from SSTable0 (10x), 3..4 -> SSTable1 (100x), 5..9 -> memtable (1000x)

const expected: u64 = if (k <= 2) k * 10 else if (k <= 4) k * 100 else k * 1000;

try std.testing.expectEqual(expected, v2);

}

}

  

test "Merge under capacity stays at same level" {

const allocator = std.testing.allocator;

  

const test_dir = "test_merge_same_level";

std.fs.cwd().deleteTree(test_dir) catch {};

try std.fs.cwd().makeDir(test_dir);

defer std.fs.cwd().deleteTree(test_dir) catch {};

  

var kvstore = try KVStore.init(allocator);

defer kvstore.close();

try kvstore.open(test_dir);

  

// Two small flushes (total entries << LEVEL0_ENTRY_BUDGET = 1000)

{

var k: u64 = 0;

while (k < 100) : (k += 1) try kvstore.put(k, k + 1);

try kvstore.flushMemtable();

k = 100;

while (k < 200) : (k += 1) try kvstore.put(k, k + 1);

try kvstore.flushMemtable();

}

  

// Compaction should merge but keep result at level 0 (under capacity)

try std.testing.expect(kvstore.levels.items.len >= 1);

try std.testing.expectEqual(@as(usize, 1), kvstore.levels.items[0].items.len);

// No level 1 created for this small dataset

if (kvstore.levels.items.len > 1) {

try std.testing.expectEqual(@as(usize, 0), kvstore.levels.items[1].items.len);

}

}

  

test "Exceeding capacity promotes to next level" {

const allocator = std.testing.allocator;

  

const test_dir = "test_merge_promote";

std.fs.cwd().deleteTree(test_dir) catch {};

try std.fs.cwd().makeDir(test_dir);

defer std.fs.cwd().deleteTree(test_dir) catch {};

  

var kvstore = try KVStore.init(allocator);

defer kvstore.close();

try kvstore.open(test_dir);

  

// Create enough entries to exceed LEVEL0 capacity (1000)

// Two flushes of 600 => total 1200 > 1000

{

var k: u64 = 0;

while (k < 600) : (k += 1) try kvstore.put(k, k);

try kvstore.flushMemtable();

  

while (k < 1200) : (k += 1) try kvstore.put(k, k);

try kvstore.flushMemtable();

}

  

// Should have promoted to level 1

try std.testing.expect(kvstore.levels.items.len >= 2);

// Level 0 should have at most one table, likely 0 after merge

try std.testing.expect(kvstore.levels.items[0].items.len <= 1);

// Level 1 should have exactly one table with merged data

try std.testing.expectEqual(@as(usize, 1), kvstore.levels.items[1].items.len);

  

// Data intact

var i: u64 = 0;

while (i < 1200) : (i += 1) {

const v = try kvstore.get(i);

try std.testing.expectEqual(@as(?u64, i), v);

}

}
```


I need help
- 