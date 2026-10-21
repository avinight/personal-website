## Structures

Since arrays cannot be used to store this data and indices have no meaning, structs are used to aggregate data when values may not be of the same type.

an array gets passed as a pointer to its first element in a function, so function can make changes to the array as it is not copied.
function is not operating on the 

functions that pass structs as a parameter gets a copy of the entire struct, including arrays. Any array inside of a struct is copied too.

Do not return the struct as it is wasteful, struct becomes copied twice. Once when calling the function, and once when assigning a return value to the original struct variable. Pass the pointer to the struct instead.

Like strncpy, strncat copies characters from one string into another. The difference is where in the destination string the copied characters are written.

strncat puts a null-terminator in the memory location following the last character it otherwise writes.

`(*p).gpa`
"." dot has a higher precedence than * star.

C has easier syntax for accessing a member through a pointer `p -> year`

## Linked Structures

In particular linked lists. Linked structures can grow or shrink called dynamic resizing.

```C
struct Node {
    int value;
    struct Node *next;
};
```

```C
typedef struct Node { // 'Node' is for convenience so we don't have 
					  //  to type 'struct node' all the time.
    int value;
    struct Node *next;
} Node;
```
`arr[i]` is translated to `*(arr + i)`. We cannot use it to access nodes that are scattered across memory.

Traversal
```C
typedef struct node {
    int value;
    struct node *next;
} Node;

int main(int argc, char **argv) {
    Node *front;	// pointer to first node of the list
    Node *curr = front;
    while (curr != NULL) {
        printf("%d", curr->value);
        curr = curr->next;
    }
    return 0;
}

```

Insertion

Testing: middle, beginning, end of linked list
**Exercise**: insertion at illegally small index like "i = -1" or "i > len(lst)"

References:

- [https://youtu.be/9P7WC5jv7eE](https://youtu.be/9P7WC5jv7eE)
- [https://youtu.be/XS05Dl8mVYU](https://youtu.be/XS05Dl8mVYU "Share link")
- [https://youtu.be/wfSY0vUvPDM](https://youtu.be/wfSY0vUvPDM "Share link")
- 