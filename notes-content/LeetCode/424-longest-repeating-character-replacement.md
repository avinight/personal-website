Tags:

---

Brute force solution. Check all n^2 substrings that satisfy the replacement condition.

Sliding Window solution.
```Python
class Solution:
    def characterReplacement(self, s: str, k: int) -> int:
        count = {}
        l = 0
        priority = 0
        for r in range(len(s)):
            count[s[r]] = 1 + count.get(s[r], 0)

            priority = max(priority, count[s[r]])
            
            if r - l + 1 - priority > k:
                count[s[l]] -= 1
                l += 1
        
        return (r - l + 1)
```

Explanation
- Maintain a sliding window and a hash map which counts the frequency of each character.
- Increase the length of the sliding window while the condition
	`(r - l + 1) - maxf <= k`
	is true. Note that `maxf` is the maximum frequency character that appears in the window.
- If `(r - l + 1) - maxf > k`, then remove the character from the sliding window by decrementing its count and shifting the left pointer. 

- We only increase the length of the sliding window if max frequency character (priority) is increased.
- If `maxf` is decreased, it doesn't change our result because we only care about the longest substring with replacement. 

Example
- `AAABABB`
- A -> AA -> AAA -> AAAB -> AAABA -> AABAB -> ABABB

	It wouldn't make sense to also count AABAB -> ABAB since the resulting length is 4.
	
![[Longest Repeating Character Replacement.png]]
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---