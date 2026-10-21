---
tags:
  - course/csc343
  - computer-science
---
Tags:

---

A superkey Y is such that $Y \rightarrow R$. A key is such that no subset of Y has this property.


$2^n$ combinations we need to check for keys. Start with singletons

We can remove all supersets of any found key since they aren't minimal.
Two key speedups
1. In fact, even if an attribute appears in an FD, if it never appears on a RHS, it will have to be in every key.
2. If, on the other hand, an attribute appears only on the RHS of FDs, never the left, it is of no help to us in computing closures. It cannot be in any key, because you could always remove it and still get the same closure.

Consider all combinations
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---