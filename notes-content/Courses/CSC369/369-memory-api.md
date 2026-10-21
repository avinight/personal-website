Tags:

---


`sizeof()` 
- is a compile-time operator (size is known at compile time)

Common errors
- not freeing memory (memory leak)
- forgetting to allocate memory
- not allocating enough memory
- forgetting to initialize allocated memory
- freeing memory before done with it (dangling pointer)
- freeing memory repeatedly (double free)
- calling `free()` incorrectly

`calloc()` allocates memory and zeroes it out
realloc() makes a new larger region of memory,
copies the old region into it, and returns the pointer to the new region

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---