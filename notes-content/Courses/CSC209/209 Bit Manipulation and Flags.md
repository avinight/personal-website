---
tags:
  - course/csc209
  - computer-science
---
Tags:

---
### Introducing Bitwise Operations
---

We can modify bits directly
Bitwise exclusive or `^` operator
Bitwise complement/negation `~` operator

negating integer 0 in C, results in all bits flipped to 1. It does not become the integer value `1`.
Preface number with `0b` for binary constants 
```C
char a = 0b00010011;
unsigned char a = 0x13;
unsigned char b = 0x14;
```

![[Bitwise Operators And Flags.png]]
![[C Bitwise Operators.png]]

### The shift operator
---
![[Bit Manipulation Check.png]]

![[Binary Shift Operation.png]]

### Bit Flags
---

![[Bit Flags.png]]

### Bit Vectors
---
Bit masking, using a bit vector to implement a set

`unsigned short` = value with 16 bits

array in struct hides implementation of the set and allows us to make a copy of the set.
![[Bit Vector Implementation.png]]

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- [https://youtu.be/T8zeV_v3_HI](https://youtu.be/T8zeV_v3_HI "Share link")
- [https://youtu.be/9sJhdX8Zioc](https://youtu.be/9sJhdX8Zioc "Share link")
- [https://youtu.be/VhEH1l9BHiI](https://youtu.be/VhEH1l9BHiI)
- [https://youtu.be/zwKGVtR-f9Q](https://youtu.be/zwKGVtR-f9Q)