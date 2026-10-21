---
tags:
  - course/csc209
  - computer-science
---
Tags:

---
## The compiler toolchain

```ad-note 
title: Definition

**The compiler toolchain** is the set of applications that, together, allow us to transform source code into a running program.
```
```ad-note 
title: Definition

An **inode** is a data structure that contains information about a file 
-   Metadata (e.g. owner, creation time)
-   Where the file contents are stored on disk

```
Follow up 1A
	`gcc -S my_prog.c` generates `my_prog.s`
`%.s` files are assembly files.

Follow up 1B
	`gcc fiddle.c` generates `a.out`

Types of files
Source code (.c)
Assembly (.s) 
Executable (.out)
Object (.o)

- `as` is the command for The Assembler, which will assemble assembly code into object code.
- The Linker links objects files into an executable. Executables are not portable, so they won't run on other machines.
- Executable has to be loaded into memory, which is the job of The Loader.

`chmod` : changes permissions

**_Main command to compile C programs_**
`gcc` : compiler
`-Wall` : all warnings
`-g`: insert debugging symbols
`-std=gnu99` : what is the version of C 
`-o` : output name

## Header Files

```ad-note 
title: Definition

**Separate compilation** is when multiple files are required, each file is compiled and assembled separately. Then, the object files are combined during the linking stage to produce an executable.

```

`compare_sorts.c`
```C
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "sorts.h"


typedef struct {
    char *name;
    SortFunc_t sort_func;
} sort_info;

const int NUM_SORTS = 3;
sort_info SORTS[] = {
    {.name = "bubble", .sort_func = bubble_sort},
    {.name = "selection", .sort_func = selection_sort},
    {.name = "insertion", .sort_func = insertion_sort}
};


SortFunc_t parse_command_line(int argc, char *argv[]) {
    if (argc > 1) {
        for (int sort = 0; sort < NUM_SORTS; sort++) {
            if (strcmp(argv[1], SORTS[sort].name) == 0) {
                return SORTS[sort].sort_func;
            }
        }
    }
    fprintf(stderr, "Unrecognized sort name. Valid names are:\n");
    for (int i = 0; i < NUM_SORTS; i++) {
        fprintf(stderr, "  %s\n", SORTS[i].name);
    }
    exit(1);
}


void check_sort(int *arr, int size) {
    for (int i = 1; i < size; i++) {
        if (arr[i - 1] > arr[i]) {
            printf("Mis-sorted at index %d\n", i);
            return;
        }
    }
}


void random_init(int *arr, int size) {
    for (int i = 0; i < size; i++) {
        arr[i] = rand();
    }
}


void max_to_min_init(int *arr, int size) {
    for (int i = 0; i < size; i++) {
        arr[i] = size - i;
    }
}


double time_sort(int size, SortFunc_t sort_func, SortFunc_t initializer) {
    int arr[size];
    initializer(arr, size);

    clock_t begin = clock();
    sort_func(arr, size);
    clock_t end = clock();

    check_sort(arr, size);

    return (double)(end - begin) / CLOCKS_PER_SEC;
}


int main(int argc, char *argv[]) {
    srand(time(NULL));

    SortFunc_t sort_func = parse_command_line(argc, argv);

    for (int size = 1; size <= 4096; size *= 2) {
        double time_spent = time_sort(size, sort_func, random_init);
        printf("%d: %f\n", size, time_spent);
    }

    return 0;
}
```

`sorts.c`
```C
#include "sorts.h"

void swap(int *arr, int index1, int index2) {
    int temp = arr[index1];
    arr[index1] = arr[index2];
    arr[index2] = temp;
}


void bubble_sort(int *arr, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 1; j < size - i; j++) {
            if (arr[j - 1] > arr[j]) {
                swap(arr, j - 1, j);
            }
        }
    }
}


void selection_sort(int *arr, int size) {
    for (int i = 0; i < size; i++) {
        int current = i;
        for (int j = i; j < size; j++) {
            if (arr[current] > arr[j]) {
                current = j;
            }
        }
        swap(arr, i, current);
    }
}

void insertion_sort(int *arr, int size) {
    for (int i = 1; i < size; i++) {
        for (int j = i; j > 0 && arr[j - 1] > arr[j]; j--) {
            swap(arr, j - 1, j);
        }
    }
}
```

`sorts.h`
```C
typedef void (*SortFunc_t)(int *, int);

void bubble_sort(int *, int);
void selection_sort(int *, int);
void insertion_sort(int *, int);

typedef struct {
    char *name;
    SortFunc_t sort_func;
} sort_info;

const int NUM_SORTS = 3;
sort_info SORTS[] = {
    {.name = "bubble", .sort_func = bubble_sort},
    {.name = "selection", .sort_func = selection_sort},
    {.name = "insertion", .sort_func = insertion_sort}
};
```


Compile into object files by
```
>gcc -c compare_sorts.c
>gcc -c sorts.c
```

List all files of type (.o)
```
>ls *.o
```

To link object files 
```
>gcc compare_sorts.o sorts.o
```

In sorts.c if we want to make a small change in a file, we can do separate compilation by
```
>gcc -c sorts.c
>gcc compare_sorts.o sorts.o
```
which takes significant time

Separate compilation has problems
- You can include inconsistent types and compiler doesn't throw an error
- Implementation and usage are in separate files 
- Files can be consistent, but separate files cannot be consistent with each other

So we use header files
- `"header" `uses header file in current directory rather than `<header>` which tells the compiler to use system library header files.
This solves the type mismatch problem of separate compilation, it keeps design (interface) consistent between all files.

## Header File Variables
---


## Makefiles
---
```ad-question

What is another term for prerequisites? Dependencies

```
```ad-question

How is a file that ends in .o generated? `gcc -C`

What does this file contain? Object files contain machine code instructions and data.

```

This is a rule in a makefile:
```make
target: dependencies
    command to build or update target
```
White space before recipe is a "Tab", not spaces

Here's a breakdown of these components:

1. **Target**: The target is the name of the task or file you want to create or update. It is the goal of the rule.
    
2. **Dependencies**: Dependencies are files or tasks that the target relies on. If any of the dependencies are newer than the target or don't exist, the target will be rebuilt.
    
3. **Command**: The command specifies how to build or update the target. It is a shell command or a series of commands that are executed when Make determines that the target needs to be updated.

When `make` is ran with no CLAs, then it evaluates the first rule in the Makefile.
Makefile will check a rule's dependencies before evaluating the recipe. If the dependency is a target, then it will execute the rule associated with it first.

**Updating Timestamps**: When you want to update the access and modification timestamps of a file (e.g., to mark a file as recently accessed or modified without making any actual changes to its content), you can use `touch`. Simply specify the file(s) you want to update

After updating a dependency, `make` will execute the recipe since the dependency is newer than the target file.

If target is newer than its dependencies, it will not execute the recipe.

Only the files that need to be compiled are compiled

### Makefile syntax
---
- ($@) Name of target
- ($?) All out of date prerequisites
- ($^) All prerequisites
- ($<) Name of First prerequisite in list of dependencies
- (%.o: %.c) each object file that needs to be built from its source file

```
OBJFILES = compare_sorts.o sorts.o

%.o: %.c sorts.h
	gcc -c $< -o $@

compare_sorts: compare_sorts.o sorts.o
	gcc $(OBJFILES) -o compare_sorts
	
.PHONY: clean
clean:
	rm compare_sorts *.o
```

`.PHONY` means `clean` isn't actually a file.
Building the target `clean` executes the `clean` rule.

In a Makefile, `.PHONY` is a special target that is used to specify targets that are not actual files but represent actions or tasks that should be executed when explicitly requested, regardless of whether a file with the same name exists or not. This is a way to tell Make that the target doesn't represent a file and should always be considered out-of-date, triggering the associated commands to run.

The `.PHONY` target is typically used to define phony targets for tasks like cleaning up generated files, running tests, generating documentation, or any other task that doesn't result in a file creation but requires specific actions to be performed.

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- [https://youtu.be/4Py9B6Z99_s](https://youtu.be/4Py9B6Z99_s "Share link")
- [https://youtu.be/uJ6KHWH_Gv4](https://youtu.be/uJ6KHWH_Gv4)
- [https://youtu.be/S6kdd4iSO4w](https://youtu.be/S6kdd4iSO4w)
- [https://youtu.be/dv6HSQ5_gdw](https://youtu.be/dv6HSQ5_gdw "Share link")
- 