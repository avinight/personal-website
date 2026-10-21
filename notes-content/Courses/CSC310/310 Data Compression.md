Tags:

---

```ad-note
title: Definition

A **Compression scheme** is a pair of functions:
1) the compressor $E: \{0, 1\}^* \to \{0, 1\}^*
2) the decompressor $D: \{0, 1\}^* \to \{0, 1\}^*$

such that $\forall x \in \{0, 1\}^*$, 
1) $D(E(x)) = x$
2) |E(x)| \leq (0.9)|x| + 1
```
Note that no such compression scheme exists.


<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---