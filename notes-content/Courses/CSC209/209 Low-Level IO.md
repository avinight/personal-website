---
tags:
  - course/csc209
  - computer-science
---
Tags:

---
## Binary Files
---
- There are only 3 major open modes
	- "r" - read
	- "w" - write
	- "a" - append (write at end)
	
- A POSIX-compliant system is one that adheres to the POSIX (Portable Operating System Interface) standards, which are a set of standards and guidelines for maintaining compatibility between different operating systems. The POSIX standards were developed by the IEEE (Institute of Electrical and Electronics Engineers) and aim to promote compatibility and portability among different Unix-like operating systems and their variants.

- We can add "b" to any of the modes to skip newline formatting/handle it correctly
- We can always add a "+" to mean potentially both read and write

```ad-note
title: What are Text Files

Text files require making strings, typically C strings to represent anything that you will write.
A text file is one which all data is first converted to arrays of chars, then you write those arrays.

A text file is kind of a binary file, that can be understood as a single long character array ending in a single character. EOF(26) instead of '\0' (0).

```
Binary files in general are just the contents of any memory, be it the stack, ROM, heap, whatever, which is written to a file for later.

- Some files are binary files that are not human readable.
- to open a binary file, add the letter `b` to the mode.

```C
size_t fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream);
```
- pointer to the data we write to the file, can also be to a variable
- size of each element writing to file
- number of elements writing to file
- FILE pointer to which we will write
- `fwrite` is writing data from memory to the file, so the memory does not need to be modified. 

```C
data_file = fopen("my_data", "wb")
```
- If file does not exist, then `fopen` will create it
- If file exists, then `fopen` destroys it


```C
size_t fread(void *ptr, size_t size, size_t nmemb, FILE *stream);
```
- `fread` takes a non-constant pointer. This reflects how the memory is being used: However, fread is writing data from the file to memory, so the parameter cannot be const.

`fread.c`
```C
#include <stdio.h>

#define NUM_ELEMENTS 5

int main() {
    FILE *data_file;
    int error;
    int numbers[NUM_ELEMENTS];
    int i;    
  
    data_file = fopen("array_data", "rb");
    if (data_file == NULL) {
        fprintf(stderr, "Error: could not open file\n");
        return 1;
    }
  
    fread(numbers, sizeof(int), NUM_ELEMENTS, data_file);
  
    for (i = 0; i < NUM_ELEMENTS; i++) {
        printf("%d ", numbers[i]);
    }
    
    printf("\n");
  
    error = fclose(data_file);
    if (error != 0) {
        fprintf(stderr, "Error: fclose failed\n");
        return 1;
    }

    return 0;
}
```

So, now that we know that `fread` and `fwrite` are duals. We use `fwrite` to place data from C programs into a binary file, and we use `fread` to bring binary data from a file into a program. However, there's a complication. You might expect that you can use fwrite to create a binary file, and then use fread on a different computer to read that data back. Unfortunately, this isn't guaranteed to work.

Different computers may represent data in different ways.

In this case, we're seeing the effect of endianness. One machine stores numbers in a little endian format: the digits should be read from right to left -- the opposite of how we read numbers normally. The other machine is storing numbers in a big endian format: the digits should be read from left to right, as we normally do.

## WAV files
```bash
od -A d -j 44 -t d2 short.wav
```
`-A` translates from base 8 to base 10
`-j` causes `od`to skip the first 44 bytes, since this is the size of the header.
`-t` consists of 2 byte values

`od` looks at wav files, file viewer for binary files.

`increase.c`
```C
#include <stdio.h>

#define HEADER_SIZE 44

/* Increases the volume of a .wav file (specified by argv[1]),
   and saves the altered version as a file whose name is
   specified by argv[2]. */
int main(int argc, char *argv[]) {
    char *input_name, *output_name;
    FILE *input_wav, *output_wav;
    short sample;
    short header[HEADER_SIZE];
    int error;
  
    if (argc != 3) {
        fprintf(stderr, "Usage: %s inputfile outputfile\n", argv[0]);
        return 1;
    }

    input_name = argv[1];
    output_name = argv[2];
  
    input_wav = fopen(input_name, "rb");
    if (input_wav == NULL) {
        fprintf(stderr, "Error: could not open input file\n");
        return 1;
    }

    output_wav = fopen(output_name, "wb");
    if (output_wav == NULL) {
        fprintf(stderr, "Error: could not open output file\n");
        return 1;
    }

    fread(header, HEADER_SIZE, 1, input_wav);
    error = fwrite(header, HEADER_SIZE, 1, output_wav); 
    if (error != 1) {
        fprintf(stderr, "Error: could not write a full audio header\n");
        return 1;
    }

    while (fread(&sample, sizeof(short), 1, input_wav) == 1) {
        sample = sample * 4;
        error = fwrite(&sample, sizeof(short), 1, output_wav);
        if (error != 1) {
            fprintf(stderr, "Error: could not write a sample\n");
            return 1;
        }
    }

    error = fclose(input_wav);
    if (error != 0) {
        fprintf(stderr, "Error: fclose failed on input file\n");
        return 1;
    }

    error = fclose(output_wav);
    if (error != 0) {
        fprintf(stderr, "Error: fclose failed on output file\n");
        return 1;
    }

    return 0;
}
```

## Moving around in Files

`Prototype for fseek`
```C
int fseek(FILE *stream, long int offset, int whence);
```
`fseek` allows us to change that file position.
It takes three parameters: 
- the first is the stream whose position we'd like to change.
- the second is a byte count indicating how much the file position should change.
- The third parameter determines how the second parameter is interpreted.

`create_student_file.c`
```C
#include <stdio.h>

#define NUM_STUDENTS 5

int main() {
    struct student {
      char first_name[20];
      char last_name[20];
      int year;
      float gpa;
    };
  
    FILE *student_file;
    int error;
    struct student s[5] = {
      {"Betty", "Holberton", 4, 3.8},
      {"Michelle", "Craig", 4, 3.5},
      {"Andrew", "Petersen", 3, 0.0},
      {"Daniel", "Zingaro", 1, 2.2},
      {"Grace", "Hopper", 6, 3.9}
    };
  
    student_file = fopen("five_students", "wb");
    if (student_file == NULL) {
        fprintf(stderr, "Error opening file\n");
        return 1;
    }
  
    fwrite(s, sizeof(struct student), NUM_STUDENTS, student_file);
    error = fclose(student_file);
    if (error != 0) {
        fprintf(stderr, "fclose failed\n");
        return 1;
    }

    return 0;
}
```

`fseek.c`
```C
int main() {
    struct student {
        char first_name[20];
        char last_name[20];
        int year;
        float gpa;
    };
  
    FILE *student_file;
    int error, student_num;
    struct student s;
  
    student_file = fopen("five_students", "rb");
    if (student_file == NULL) {
        fprintf(stderr, "Error opening file\n");
        return 1;
    }
  
    printf("Type -1 to exit.\n");
    printf("Enter the index of the next student to view: ");

    scanf("%d", &student_num);
    while (student_num >= 0) {
        fseek(student_file, student_num * sizeof(struct student), SEEK_SET);
    
        error = fread(&s, sizeof(struct student), 1, student_file);
        if (error == 1) {  
            printf("Name: %s %s\n", s.first_name, s.last_name);
            printf("Year: %d. GPA: %.2f\n", s.year, s.gpa);
        }
        else {
            fprintf(stderr, "Error: student could not be read.\n");
        }
        printf("Enter the index of the next student to view: ");
        scanf("%d", &student_num);
    }
    
    error = fclose(student_file);
    if (error != 0) {
        fprintf(stderr, "fclose failed\n");
        return 1;
    }

    return 0;
}
```

Notice that we multiply the number of the student by the size of a student struct. Forgetting to multiply by the size of the struct is a common error. If we don't do that, then we will end up moving the file position to a particular byte -- not to the beginning of a struct.

Rather than moving around arbitrarily through a file, it's also occasionally useful to move to the beginning of a file. You might do that, for example, if you wanted to read the entire file again. 
You can do that using fseek, by supplying a value of 0 for the second parameter and SEEK_SET as the third parameter.

```C
fseek(myfile, 0, SEEK_SET)
```

But for this specific case, there's an easier way. The function rewind can be used to move to the beginning of a file. It takes only one parameter, for the stream, and returns nothing, so it is simpler than using fseek. Of course, for any other kind of move through a file, you'll want to use fseek.

```C
void rewind(FILE *stream);
```


<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- [Introducing Binary Files](https://youtu.be/duffUfQCozo)
- [Writing Binary Files](https://youtu.be/OUrePlTuIzc)
- [Reading Binary Files](https://youtu.be/NBkFUyvS6pM)
- [Putting it Together: wav files](https://youtu.be/oQWZdw8KRfw)
- [Increasing the Sound in wav Files](https://youtu.be/SmxSSBJePuA "Share link")
- [Learn about structs](https://youtu.be/x13LPtnrWNU "Share link")
- [Moving Around in Structs](https://youtu.be/d68CLg6uFbI)