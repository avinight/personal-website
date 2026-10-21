---
tags:
  - computer-science
---
Tags:
Links: [[148-CSC148]]

---
# ADTs

An **abstract data type** (or ADT) defines some kind of data and the operations that can be performed on it.

It is a pure interface, with no mention of an implementation—that’s what makes it _abstract_.

In contrast to this, a **data structure** is a concrete strategy for storing some data.

[[Set (mathematics)]]
- Data: a collection of unique elements
- Operations: get size, insert a value (without introducing duplicates), remove a specified value, check membership

Multiset
- Data: a collection of elements (possibly with duplicates)
- Operations: same as Set, but the insert operation allows duplicates

List
- Data: an ordered sequence of elements
- Operations: access element by index, insert a value at a given index, remove a value at a given index

[[Linear Map]]
- Data: a collection of key-value pairs, where each key is unique and associated with a single value
- Operations: lookup a value for a given key, insert a new key-value pair, remove a key-value pair, update the value associated with a given key

Iterable
- Data: a collection of values (may or may not be unique)
- Operations: iterate through the elements of the collection one at a time.

Stack
- Data: a collection of items
- Operations: determine whether the stack is empty, add an item (_push_), remove the most recently-added item (_pop_)
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---