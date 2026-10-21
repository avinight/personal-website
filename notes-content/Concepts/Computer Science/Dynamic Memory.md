---
tags:
  - computer-science
---
Tags:

---

Have to last beyond when the function returns
`void *malloc(size_t size);`

```ad-question

What is a `void *` pointer?

A void pointer is a generic or untyped pointer that can be used to point to objects of any data type. In other words, it's a pointer that doesn't have information about the data type it's pointing to, making it flexible and versatile.

```
pointers store the type of the information to which they point.
-   pointers should always to a legal address of its type.
```ad-note
title: Definition

Memory leak: inaccessible memory is stored on the heap

```
```ad-note
title: Definition

Dangling pointer: a pointer that points to a memory location that has already been freed. (This is unsafe)

```

You want to call  `free(*pt)` to free allocated memory on the heap.

An ENOMEM error occurs when the program runs out of memory.
use parameter to store address of dynamically allocated memory.

Mistakes:
- param.c
- local variable on the stack doesn’t modify what’s on the heap.

> **Question**: When do we want to use dynamically allocated memory?

If you don’t know the size of an array at compile time, you should use dynamically allocated memory rather than statically defined arrays.

each malloc statement should have a corresponding free statement somewhere in your program.

## Review
---
The type of the value returned from the function malloc is `void *`.

The parameter to malloc is the size of the chunk of memory to allocate and the return value is a pointer to that newly-allocated memory.

calling free does not reset the values in the freed memory to NULL.

leaving unfreed but no longer accessible memory on the heap causes a memory leak.

`strncpy()`copies up to n characters, stopping with the first null terminator in s2 or once it reaches n characters.

Like strncpy, strncat copies characters from one string into another. The difference is where in the destination string the copied characters are written.

strncat puts a null-terminator in the memory location following the last character it otherwise writes.

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- https://piazza.com/class/lmggk4oi8z51oy/post/120

- [https://youtu.be/lMO91Iz7zoU](https://youtu.be/lMO91Iz7zoU)
- [https://youtu.be/gLAYMjZFxL0](https://youtu.be/gLAYMjZFxL0)
- [https://youtu.be/4lwrPZxOZYM](https://youtu.be/4lwrPZxOZYM "Share link")
- [https://youtu.be/djwnyNKLGoM](https://youtu.be/djwnyNKLGoM "Share link")
- [https://youtu.be/O_2DJIJyklI](https://youtu.be/O_2DJIJyklI)