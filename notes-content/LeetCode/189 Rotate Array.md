Tags:

---

Extra Memory Solution


Array Reversal Solution
```Python
class Solution:
	def rotate(self, nums: List[int], k: int) -> None:
		"""
		Do not return anything, modify nums in-place instead.
		"""
		count = k % len(nums)
		nums.reverse()
		left = nums[:count]
		left.reverse()
		nums[:count] = left
		right = nums[count:]
		right.reverse()
		nums[count:] = right
```

Array Traversal Solution


<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---