---
tags:
  - leetcode
  - algorithms
---
Tags:

---

No Hashmap Solution
```Python
    def isValid(self, s: str) -> bool:
        opened = ['(', '{', '[']
        closed = [')', '}', ']']
        stack = []

        for i in range(len(s)):
        
            if s[i] in opened:
                stack.append(s[i])
                
            if s[i] in closed:
            
                if not stack:
                    return False
                    
                c = stack.pop()
                p = 0
                while p < len(opened) and opened[p] != c:
                    p = p + 1

                if s[i] != closed[p]:
                    return False

        if stack:
            return False

        return True
```

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---