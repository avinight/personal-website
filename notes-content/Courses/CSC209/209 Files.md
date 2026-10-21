---
tags:
  - course/csc209
  - computer-science
---
Tags:

---

## Files: five standard actions

Open a file
```C
FILE *fopen(const char *pathname, const char *mode*)
```

Read from a file
```C
// Text I/O

int fscanf(FILE *stream, const char *format, ...)
char *fgets(char *s, int size, FILE *stream) // get a string from a stream 

// Binary I/O

size_t fread(void *ptr, size_t size, size_t nmemb, FILE *stream)
```

Write to a file
```C
// Text I/O

int fprintf(FILE *stream, const char *format, ...)

// Binary I/O

size_t fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream)
```

What are the risks in using fprintf and printf?
- The results of the statements are undefined in the event of a crash. 
- In the case of abnormal termination, the executed statements may not be written to the disk or the screen. 
- They are not reliable functions for debugging.
- It is unknown what the results of the calls will be if your computer loses power in the middle of the program

<u>Change position in a file</u>
```C
int fseek(FILE *stream, long offset, int whence)
```

- `stream` is a pointer to a `FILE` object, typically obtained from functions like `fopen` when opening a file for reading or writing.
- `offset` is of type `long` and represents the number of bytes to move the file position indicator.
- `whence` is an integer that specifies the reference point for the offset. It can take one of three values:
    - `SEEK_SET` (0): The offset is relative to the beginning of the file.
    - `SEEK_CUR` (1): The offset is relative to the current position of the file pointer.
    - `SEEK_END` (2): The offset is relative to the end of the file.

The `fseek` function is used to set the file position indicator within a file stream, allowing you to move to a specific location in the file. It's commonly used for seeking to specific positions in a file, reading or writing data at that position, or changing the current position within a file.

<u>Close a file</u>
```C
int fclose(FILE *stream)
```

Pointer gets stored on the stack
But the actual internal data structure that C provides is heap allocated

`od` - octal dump
shows us the raw contents of the file

```bash
$ od --address-radix=x --format=c --format=dC <FILE>
```
- `d` interpreted as signed integer

`fprintf` converts int to string to display.

writing more memory by changing 
```C
fwrite(&i, sizeof(int), 3, fp)
```
- might corrupt the data

Section header table specifies where the actual data is stored.
```ad-note

`objdump` is a utility program for reading object and executable files.
it will show the rodata section and maybe other sections 

```

`--wide` is the format .

read all the data, know the metadata, display bytes in hex, just cuz display any human readable characters by displaying the characters.

Takes sequence of zeros and ones and finds section metadata, parse all of the section headers, then go to the offset and display in some sort of human readable way.

metadata - data about data

```ad-note
title: Definition

.rodata = "read-only data"


```



<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- [Files video 1](https://youtu.be/RXbnIZcCoPA "Share link")
- [Files video 2](https://youtu.be/Hzuku58iReU)
- [Files video 3](https://youtu.be/C9ihXyPhKJE)
- [Files video 4](https://youtu.be/yTChMnyie5s)
- [Files video 5](https://youtu.be/QmJ6cAk8yMI "Share link")
