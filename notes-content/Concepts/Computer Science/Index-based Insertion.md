Tags:
Links: [[Linked Lists]], [[Linked List Mutation]]

---
# Index-based Insertion

```Python
class LinkedList:
    def insert(self, index: int, item: Any) -> None:
        """Insert a new node containing item at position <index>.

        Precondition: index >= 0.

        Raise IndexError if index > len(self).

        Note: if index == len(self), this method adds the item to the end
        of the linked list, which is the same as LinkedList.append.

        >>> lst = LinkedList([1, 2, 10, 200])
        >>> lst.insert(2, 300)
        >>> str(lst)
        '[1 -> 2 -> 300 -> 10 -> 200]'
        >>> lst.insert(5, -1)
        >>> str(lst)
        '[1 -> 2 -> 300 -> 10 -> 200 -> -1]'
        """
```

Traversal
```Python
def insert(self, index: int, item: Any) -> None:
    curr = self._first
    curr_index = 0

    while curr is not None and curr_index < index - 1:
        curr = curr.next
        curr_index += 1
```

```Python
    def insert(self, index: int, item: Any) -> None:
        curr = self._first
        curr_index = 0

        while curr is not None and curr_index < index - 1:
            curr = curr.next
            curr_index += 1

        # assert curr is None or curr_index == index - 1
        if curr is None:
            pass
        else: # curr_index == index - 1
            pass
```

```Python
    def insert(self, index: int, item: Any) -> None:
        curr = self._first
        curr_index = 0

        while curr is not None and curr_index < index - 1:
            curr = curr.next
            curr_index += 1

        # assert curr is None or curr_index == index - 1
        if curr is None:
            # index - 1 is out of bounds. The item cannot be inserted.
            raise IndexError
        else: # curr_index == index - 1
            # index - 1 is in bounds. Insert the new item.
            new_node = _Node(item)
            curr.next = new_node  # Hmm...
```

```Python
    def insert(self, index: int, item: object) -> None:
        curr = self._first
        curr_index = 0

        while curr is not None and curr_index < index - 1:
            curr = curr.next
            curr_index += 1

        # assert curr is None or curr_index == index - 1
        if curr is None:
            # index - 1 is out of bounds. The item cannot be inserted.
            raise IndexError
        else: # curr_index == index - 1
            # index - 1 is in bounds. Insert the new item.
            new_node = _Node(item)
            new_node.next = curr.next  # THIS LINE IS IMPORTANT!
            curr.next = new_node
```