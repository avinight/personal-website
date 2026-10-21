---
tags:
  - computer-science
---
Tags:
Links: [[Linked Lists]]

---
# Linked List Mutation
Methods:
	[[Linked List append]]
	[[Index-based Insertion]]

A more general initializer
```Python
class LinkedList:
    def __init__(self, items: list) -> None:
        """Initialize a new linked list containing the given items.

        The first node in the linked list contains the first item
        in <items>.
        """
        self._first = None
        for item in items:
            self.append(item)
```

Common Error: Update Order

Wrong:
```Python
curr.next = new_node
new_node.next = curr.next
```

Solution: Simultaneous Assignment
```Python
a, b = 1, 2  # Assigns 1 to a and 2 to b
```

These statements are equivalent:
```
# Version 1
curr.next, new_node.next = new_node, curr.next
# Version 2
new_node.next, curr.next = curr.next, new_node
```
