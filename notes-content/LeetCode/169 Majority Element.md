Tags:

---

```Java
import java.util.HashMap;

class Solution {
    public int majorityElement(int[] nums) {
        HashMap<Integer, Integer> map = new HashMap<>();
        
        int candidate = nums[0];
        int maxCount = 0;
        for (int i = 0; i < nums.length; i++) {
            map.put(nums[i], 0);
        }

        for (int i = 0; i < nums.length; i++) {
            map.put(nums[i], map.get(nums[i]) + 1);
            if (map.get(nums[i]) > maxCount) {
                candidate = nums[i];
                maxCount = map.get(nums[i]); 
            }
        } 
        return candidate;
    }
}
```

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- [https://en.wikipedia.org/wiki/Boyer–Moore_majority_vote_algorithm](https://en.wikipedia.org/wiki/Boyer%E2%80%93Moore_majority_vote_algorithm "https://en.wikipedia.org/wiki/Boyer–Moore_majority_vote_algorithm")