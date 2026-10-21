---
tags:
  - leetcode
  - algorithms
---
Tags:

---

My solution doesn't encode correctly since "-" may be in a string, but passes nonetheless
```Python
class Solution:

    def encode(self, strs: List[str]) -> str:
        new = ""
        for string in strs:
            new = new + string + "-"
        return new

    def decode(self, s: str) -> List[str]:
        strs = []
        while s != "":
            k = s.find("-")
            strs.append(s[:k])
            s = s[k+1:]
        return strs
```

Correct Solution with correct delimiter
```Python
class Solution:
    
    def encode(self, strs: List[str]) -> str:
        res = ""
        for s in strs:
            res += str(len(s)) + "#" + s
        return res

    def decode(self, s: str) -> List[str]:
        res = []
        i = 0
        
        while i < len(s):
            j = i
            while s[j] != '#':
                j += 1
            length = int(s[i:j])
            i = j + 1
            j = i + length
            res.append(s[i:j])
            i = j
            
        return res

```
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---