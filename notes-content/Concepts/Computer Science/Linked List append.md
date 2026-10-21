---
tags:
  - computer-science
---
Tags:
Links: [[Linked List Mutation]]

---
# Linked List Append
```Python
class LinkedList:
    def append(self, item: Any) -> None:
        """Add the given item to the end of this linked list."""
```

```Python
    def append(self, item: Any) -> None:
        """Add the given item to the end of this linked list."""
        curr = self._first
        while curr is not None:
            ... curr.item ...
            curr = curr.next
```
Off-by-one error

```Python
    def append(self, item: Any) -> None:
        """Add the given item to the end of this linked list."""
        curr = self._first
        while curr.next is not None:
            curr = curr.next

        # After the loop, curr is the last node in the LinkedList.
        # assert curr is not None and curr.next is None
```

`curr` could be none

```Python
    def append(self, item: Any) -> None:
        """Add the given item to the end of this linked list."""
        curr = self._first
        while curr.next is not None:   # TODO: what is curr starts off as None?
            curr = curr.next

        # After the loop, curr is the last node in the LinkedList.
        # assert curr is not None and curr.next is None
        new_node = _Node(item)
        curr.next = new_node
```

Complete
```Python
    def append(self, item: Any) -> None:
        """Add the given item to the end of this linked list."""
        curr = self._first
        if curr is None:
            new_node = _Node(item)
            self._first = new_node
        else:
            while curr.next is not None:
                curr = curr.next

            # After the loop, curr is the last node in the LinkedList.
            # assert curr is not None and curr.next is None
            new_node = _Node(item)
            curr.next = new_node
```