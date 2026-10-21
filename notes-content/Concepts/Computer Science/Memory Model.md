Tags:
Links: [[Computer Science]], [[148-CSC148]]

---
# Memory Model

<a href=https://en.wikipedia.org/wiki/Hash_table> Hash Table </a>

Function gotcha
Do not assign a function parameter in hopes of changing the argument

```Python
def (x, ...):
	x = 10
	... # other code
if __name__ = '__main__':
	course = 148
	f(course, ...)
```

Assignment returns a new object

```Python
lst = [9]
lst1 = ['x'] + lst
print(lst)
>>> [9]
```

Methods modify/mutates the object

```Python
lst = [9]
lst.append(['x'])
lst
>>> [9, 'x']
```