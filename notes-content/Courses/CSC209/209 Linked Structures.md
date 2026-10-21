---
tags:
  - course/csc209
  - computer-science
---
Tags:

---
`traverse.c`
```C
#include <stdio.h>
#include <stdlib.h>

typedef struct node {
    int value;
    struct node *next;
} Node;

Node *create_node(int num, Node *next) {
    Node *new_node = malloc(sizeof(Node));
    new_node->value = num;
    new_node->next = next;
    return new_node;
}

int main() {

    Node *front = NULL; 

    front = create_node(3, front);
    front = create_node(2, front);
    front = create_node(1, front);

    Node *curr = front;
    while (curr != NULL) {
        printf("%d\n", curr->value);
        curr = curr->next;
    }
    return 0;
}
```

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- [https://youtu.be/gRxB1UrI5ow](https://youtu.be/gRxB1UrI5ow "Share link")
- [https://youtu.be/QCJRnqXlKxM](https://youtu.be/QCJRnqXlKxM "Share link")
- [https://youtu.be/N-2gi5hDOEA](https://youtu.be/N-2gi5hDOEA "Share link")
- [https://youtu.be/blRVdSaq5oM](https://youtu.be/blRVdSaq5oM "Share link")
