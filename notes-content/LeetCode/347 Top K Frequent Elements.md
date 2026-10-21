Tags:

---


O(n) Bucket Sort
```Python
class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        count = {}
        freq = [[] for i in range(len(nums) + 1)]

        for n in nums:
            count[n] = 1 + count.get(n, 0)
        for n, c in count.items():
            freq[c].append(n)

        res = []
        for i in range(len(freq) - 1, 0, -1):
            for n in freq[i]:
                res.append(n)
                if len(res) == k:
                    return res
```

We can also use a heap in O(k log n) > O(n) time

O(n log n) with sorting
```Python
def topKFrequent(self, nums: List[int], k: int) -> List[int]:
	hashmap = {}
	freq = []
	for num in nums:
		hashmap[num] = 1 + hashmap.get(num, 0)
	hashmap = dict(sorted(hashmap.items(), key=lambda item: item[1], reverse=True))
	freq = list(hashmap.keys())
	return freq[:k]
```
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---