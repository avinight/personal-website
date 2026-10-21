---
tags:
  - math
---
Tags:
Links: [[List of Algorithms]]

---
# Binary Search Algorithm

Algorithm Intuition
1. Compute the middle index of an array. 
2. Compare input to the item at that index.
3. If two are equal, the search is successful.
4. Else, dive into while loop and look into either the upper or lower subarray.
5. If x is in the upper subarray, assign the first value = mid + 1
6. If x is in the lower subarray, assign the last value = mid - 1

Binary search runs in $\mathcal{O}(\log_2 n)$ time because it divides the list by 2.

High-level implementation
```
while (top >= bot and index = 0)
	mid:= (bot + top) // 2
	if a[mid] = x then index := mid
	if a[mid] > x:
		then top:= mid - 1
		else bot:= mid + 1
end while
```
"If index has the value 0 at this point, then the while loop was not entered because top , bot, and so x is not in the array. Otherwise, index gives the index of the array where x is located."

Python Implementation
```Python
	first = 0
    last = len(lst) - 1
    while first <= last:  # Inequality was changed to non-strict since
        # first = last = mid
        mid = (last + first) // 2
        if lst[mid] == t:  # Index was changed to mid
            # b/c it would have been ignored
            return mid
        if t < lst[mid]:
            last = mid - 1
        else:
            first = mid + 1
    return -1
```


<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---