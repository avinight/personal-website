Tags:
Links: [[148-CSC148]]

---
# For Loop

### Gotcha

```Python
lst = [6, 2, 0, 44]
for item in lst:
	item = item + 1
print(lst)
>>> [6, 2, 0, 44] # Why? Because item points to new values without actually modifying lst.
```


<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- https://en.wikipedia.org/wiki/For_loop