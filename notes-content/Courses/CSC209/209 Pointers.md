Tags:

---
## What are pointers?
- Stores address of another variable and these variables have address.
- `“*” `used before a declaration is the type used to access the value pointed to by a pointer.
- `“&”` operator gives us the address of a variable.
- `“*”`is the dereference operator, which tells the compiler to use the value stored in the address that is stored in the pointer.

*A common gotcha is* 
```C
int *pt = q;
```
is equivalent to 
```C
int *pt; pt = q
```
and not 
```C
int *pt; *pt = q
```

because pt is a variable of type `int*`

Pointers as parameters to functions

- This is helpful if you wanna change the value of a variable directly instead of returning a variable which is assigned a value.

All that is being passed into a function that changes an array is a pointer 

Size of integer = 4 bytes, size of pointer = 8 bytes

`“+”` operator is 
```C
p = p + (sizeof(type) * n)`
```

```C
Address of A[i] = address of A + (i * size of one element of A)`
```

```C
p[k] == *(p + k)
```

We can store the address of a pointer in another variable.

When do we use the type int ?
-   When we want to pass an array of pointers to integers to a function, int ** is the type of the function parameter.
-   A pointer to a pointer to an integer has type int.
-   The address of a pointer to an integer has type int.

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---

- [https://youtu.be/ZyJTQ_fYIGE](https://youtu.be/ZyJTQ_fYIGE "Share link")
- [https://youtu.be/3kiREQGdZ1Q](https://youtu.be/3kiREQGdZ1Q)
- [https://youtu.be/X3UDoASpX_Q](https://youtu.be/X3UDoASpX_Q)
- [https://youtu.be/5-VksNFPuIE](https://youtu.be/5-VksNFPuIE "Share link")
- [https://youtu.be/RkMb4l2rt5E](https://youtu.be/RkMb4l2rt5E)
- [https://youtu.be/DG20gUWt8jk](https://youtu.be/DG20gUWt8jk "Share link")
- [https://youtu.be/mRoUDsPRdhs](https://youtu.be/mRoUDsPRdhs)
- 