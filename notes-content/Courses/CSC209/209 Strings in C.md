Tags: 

---
## Strings

Strings are a char array with a null character at the end `\0`, never displayed, which marks the end of a string. In the following example, the last 15 characters are set to the null terminator character.

```C
int main() {
	char text[20] = "hello"; // string variable

	text[0] = 'j';
	
	printf("%s\n", text);
	return 0;
}
```

Note that it is illegal for the initializer to be longer than the size of the char array. But it is legal for the array and initializer to be the same size. 
You are allowed to omit array size completely, compiler will allot a char array of size $n+1$.
Omitting size does not mean the size is variable and can be changed.

String literals are constants that cannot be changed.

> **Question**: Why are string literals a pointer when arrays are also pointers?

```C
int main() {
	char *text = "hello"; // string literal

	text[0] = 'j';
	
	printf("%s\n", text);
	return 0;
}
```

`sizeof()` is not the way to determine the number of characters in the string or length of array before compile time as it measures the bytesize allocated by the array.

**Common Mistake**: trying to use sizeof() in a function that was passed in an array as a parameter.

Must use `#include <string.h>`, which contains all the prototypes of the C string functions.

`%lu` means unsigned long

Prototype: `size_t strlen(const char *s);` 

`strlen` counts the number of characters before the null termination character.

<u>Copying and concatenating strings</u>

- When we copy a string, we overrite what was previously there.
- When we concatenate a string, we add to the end of what was previously there in the other.
`char *strcpy(char *s1, const char *s2);`

`strcpy` is unsafe as it doesnt check if a `str` fits in an array of smaller size

`char *strncpy(char *s1, const char *s2, int n);`
- However, it is not guaranteed to add a null terminator character unless it finds one in the first n characters of s2. So explicitly add the null termination character.

`char *strcat(char *s1, const char *s2);
`strcat` is unsafe, size it doesn't check size of arrays so it might add when theres no space

`char *strncat(char *s1, const char *s2, int n);` always adds a null terminator to the end of s1.

Proper way to call `strncat`
```C
#include <stdio.h>
#include <string.h>

int main() {
    char s1[30];
    char s2[14] = "University of";
    char s3[15] = " C Programming";
    strcpy(s1, s2);
    strncat(s1, s3, sizeof(s1) - strlen(s1) - 1);
    printf("%s\n", s1);
    return 0;
}
```
n = maximum number of chars to add to the end of s1.
n = size of array - characters already in s1 - 1 to make room for null terminator.
<u>Searching</u>

`char *strchr(const char *s, int c);`
- returns a pointer to the first character that was found in string s (not its index).
- returns NULL if character was not found in string s.

- string we search for is called substring
`char *strstr(const char *s1, const char *s2);`
- first occurrence of the substring in s2

Lab 4 truncate.
```C
/*
    Write a function named truncate() that takes a string s and a
    non-negative integer n. If s has more than n characters (not including the
    null terminator), the function should truncate s at n characters and
    return the number of characters that were removed. If s has n or
    fewer characters, s is unchanged and the function returns 0. For example,
    if s is the string "function" and n is 3, then truncate() changes s to
    the string "fun" and returns 5.
*/
int truncate(char *s, int n) {
    int len = strlen(s);
    int count = 0;
    for (int i = 0; i < len; i++) {
        if (len - i > n) {
            s[len - i] = '\0';
            count += 1;
        }
    }
    return count;
}
```
This code fails because
1.  The loop `for (int i = 0; i < len; i++)` will not truncate the string `s` as intended. It is currently only checking the length of `s` and not actually changing any characters.
    
2.  The assignment `s[len - i] = '\0'` is not correct. This will set the characters of the string to null terminators starting from the end of the string.
    
3.  The calculation `len - i` is not correct. It will always result in a positive integer, even when `i` is equal to or greater than `len`, which will cause an out-of-bounds memory access.

# Lecture
initialize a null array but not a valid C string

```C
char *name = "David";
```

String literal represents read only data
makes name refer to a string literal.

formally, the behaviour is undefined if you try to write to those addresses.
so it does not treat it as a constant.

Probably gonna be an error.
String literals are immutable.

Whenever you create or modify a string, you must ensure it is null-terminated.
There is no length attribute, only a null terminator.

Put the data where the memory has been allocated for that data

## Strings.pdf

first decays into a pointer

String literals get copied byte by byte into the heap or stack

string interning

it is tempting to refer to string literals not pointers 
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- [https://youtu.be/q1p7XTATtLY](https://youtu.be/q1p7XTATtLY "Share link")
- [https://youtu.be/dDuz7_6AH0A](https://youtu.be/dDuz7_6AH0A "Share link")
- [https://youtu.be/RjSBOiswvxo](https://youtu.be/RjSBOiswvxo)
- [https://youtu.be/I7CikDELaBo](https://youtu.be/I7CikDELaBo "Share link")
- [https://youtu.be/h05o1Ow1iZo](https://youtu.be/h05o1Ow1iZo)
- [https://youtu.be/OsZbsv-FUs0](https://youtu.be/OsZbsv-FUs0 "Share link")
- 