---
tags:
  - leetcode
  - algorithms
---
Tags:

---

Brute-Force
```Python
def hIndex(self, citations: List[int]) -> int:
	space = [0] * (len(citations)+1)
	for i in range(len(citations)+1):
		for j in range(len(citations)):
			if citations[j] >= i:
				space[i] += 1
	
	max = 0
	for i in range(len(space)):
		if space[i] >= i and i > max:
			max = i
	return max
```


First sort
- Sort
- 

```Python
def hIndex(self, citations: List[int]) -> int:

	citations.sort()
	hindex = len(citations)
	i = 0
	while i < len(citations):
		if citations[i] < hindex:
			hindex -= 1
		if citations[i] >= hindex:
			break
		i += 1
	return hindex
```


<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---