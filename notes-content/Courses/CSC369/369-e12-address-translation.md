---
tags:
  - course/csc369
  - computer-science
---
Tags:

---

```C
#define N 409600000  
#define M    100000  
#define PAGESIZE 4096  
  
**//Program 1**  
int main(int argc, char **argv){  
  int i;  
  int *X  = malloc(N * sizeof(int));  
  
  for (i = 0; i < M; i++)  
     X[**i**] = **i*PAGESIZE**;  
  return 0;  
}  
  
**//Program 2**  
int main(int argc, char **argv){  
  int i;  
  int *X  = malloc(N * sizeof(int));  
  
  for (i = 0; i < M; i++)  
     X[**i*PAGESIZE**] = **i**;  
  return 0;  
}
```

Which program takes longer? **2**
**On each iteration of the second program, the operating system has to allocate a new physical frame for that process each time it jumps pages, which causes a lot of overhead for the operating system. Meanwhile, the first program iterates 1024 times per page. Assigning new virtual pages to physical frames for that process is not a lot of load on the operating system.**

Suppose addresses are 16 bits. The page table is as follows: 
0 -> B0 
1 -> 3F 
2 -> 71 
3 -> 1C 
pages are 1024 bytes and the top 6 MSBs are the page number 

Given the virtual (logical) address 0x0BED
What is the binary representation of the address?
**0000101111101101**
- Hint:  python makes a good translator between hex, binary, and decimal.  The functions hex() and bin() are pretty handy.
- It is  a good idea to use spaces to group the bits for each hex digit, e.g. 0000 1011 1110 1101. This makes it easier to count the bits when splitting an address into the page number and offset parts.

What is the page number? Enter your answer in decimal or hexadecimal representation.
**2**
- First 6 bits: **0000 10**11 1110 1101   = 2  (in decimal)

What is the page offset (in hexadecimal)?
**0x3ED**

What is the frame number? (Enter your answer in hexadecimal representation.)
**0x71**
- Last 10 bits: 0000 10**11 1110 1101**   = 0x3ED

What is the physical address in binary?
**011100011111101101**
- Page Frame = 0x71 = 0111 0001
- Page Offset = 0x3ED = 11 1110 1101
- Physical Address = (Page Frame << 10) | Page Offset = 01 1100 01**11 1110 1101**

What is the physical address in hexadecimal?
**0x1C7ED**
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---