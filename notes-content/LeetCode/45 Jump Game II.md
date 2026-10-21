Tags:

---


```Python
def jump(self, nums: List[int]) -> int:
	count = 0
	furthest = 0
	end = 0
	for i in range(len(nums)-1):
		furthest = max(furthest, i + nums[i])
		if i == end:
			end = furthest
			count += 1
		i += 1
	return count
```

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---