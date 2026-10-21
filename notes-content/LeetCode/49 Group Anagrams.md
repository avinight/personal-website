---
tags:
  - leetcode
  - algorithms
---
Tags:

---

O(n) Solution
```Python
def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
	hashmap = {}
	for string in strs:
		new_string = ''.join(sorted(string))
		if new_string not in hashmap:
			hashmap[new_string] = []
		hashmap[new_string].append(string)
	return hashmap.values()
```

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---