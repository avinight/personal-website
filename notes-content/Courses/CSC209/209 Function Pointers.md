---
tags:
  - course/csc209
  - computer-science
---
Tags:

---

### Video 1
---
The problem is having to change the code every time we want to explore a different function.

Function pointer prototype:
`return_value (*func_name) (func_args)`

Function pointers just have the address of a function as data, instead of an integer or string.

The problem is now that we still have to change the function and recompile every time we want to use a different function.

Q1. Consider the following function:  
  
```C
char * my_func(char * filename) {  
    // contents not shown  
}  
```
  
Which of the following lines would compile correctly following this function?
- `char * x = my_func; `
- `char * x = my_func("blah.txt"); ` This one
- `char * (*x) (char *) = my_func; ` This one
- `char * (*x) (char *) = my_func("blah.txt"); `
- `char x[10] = my_func("blah.txt");`

### Video 2
---
Select function to run from the command line

```C
typedef void (*SortFunc_t)(int *, int);

typedef struct {
char *name;
SortFunc_t sort_func;
} sort_info;

void bubble_sort(int *, int);
void selection_sort(int *, int);
void insertion_sort(int *, int);
const int NUM_SORTS = 3;
sort_info SORTS[] = {
{.name = "bubble", .sort_func = bubble_sort},
{.name = "selection", .sort_func = selection_sort},
{.name = "insertion", .sort_func = insertion_sort}
};
```


![[Function Pointers Study.png]]
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- https://youtu.be/siSFYWHxWpI?si=9Cwyv2LeA3f4RVSz
- https://youtu.be/fd-w2HLIzjY?si=cIXti1-KrSFZjm5n