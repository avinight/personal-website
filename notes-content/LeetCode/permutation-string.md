Tags:

---

There are two solutions to the problem. 

Solution 1 Explanation:
- We use a hashmap to store the contents of `s1`. 
- We use a sliding window technique with `s1.size` length on `s2` and at each step compare the contents of the sliding window with the hashmap. This can also be done using a hashmap.
- Time Complexity: O(26n)

Solution 2 Explanation:
- We maintain another variable called `matches`. This improves the first solution 

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---