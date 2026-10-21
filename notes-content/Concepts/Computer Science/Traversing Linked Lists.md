Tags:
Links: [[148-CSC148]]

---
# Traversing Linked Lists

Template
```Python
curr = my_linked_list._first
while curr is not None:
    ... curr.item ...
    curr = curr.next
```
Explanation
```Python
curr = my_linked_list._first   # 1. Initialize curr to the start of the list
while curr is not None:        # 2. curr is None if we've reached the end of the list.
    ... curr.item ...          # 3. Do something with the current *element* curr.item.
    curr = curr.next           # 4. "Increment" curr, setting it to refer to the next node.
```