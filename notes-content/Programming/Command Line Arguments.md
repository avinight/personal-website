strtol = “string to long”
```C
long int strtol(const char *str, char **endptr, int base);
```
- extracts the integer from string.
- `str` is a pointer to the null-terminated string you want to convert to a long integer.
- `endptr` is a pointer to a pointer to `char`. It will be updated by the function to point to the first character following the last character that was successfully converted. If no conversion was performed, it points to the original string.
- `base` is an integer that specifies the number base (radix) to use for the conversion. It can be between 2 and 36, with common values being 10 for decimal, 16 for hexadecimal, etc.
strtol skips over leading white space, but trailing whitespace is considered to be unconverted.

argc = argument count
argv = argument vector

CLA’s are always strings, but you can use strtol to convert them to integers.

always check the correctness of the CLAs

References:
- [https://youtu.be/LmesoErTnGA](https://youtu.be/LmesoErTnGA "Share link")
- [https://youtu.be/8WCj1cHx-N0](https://youtu.be/8WCj1cHx-N0)
- [https://youtu.be/09pLPf_JINk](https://youtu.be/09pLPf_JINk)
- 