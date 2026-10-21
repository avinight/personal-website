---
tags:
  - math
---
Tags: #Theorem

---
-   Proved by: 
-   References: [[Limits]]
-   Justifications:  
-   Generalizations:
-   Counterexamples: [[Limit definitions that don't work]]
```ad-note
title: Theorem
color: 0, 236, 220

Theorem. If $f$ approaches a limit $L$ near a and $M$ near a, then $L = M$.
```
```ad-note
title: Proof
color: 255, 0, 0

Proof: Assume there is a $\delta_1$ st. $0 < |x-a| < \delta_1 \implies |f(x) - L| < \epsilon$

Prove, there is a $\delta_2$ st. $0 < |x-a| < \delta_2 \implies |f(x) - L| < \epsilon$
Take $\delta = min(\delta_1, \delta_2)$, so $0 < |x - a| < \delta \implies$ both. 

$$\begin{align}|L - M| &= | L - f(x) + f(x) - M | \\ &\leq |f(x) - L| + |f(x) - M| \\ &= \frac{\epsilon}{2} + \frac{\epsilon}{2} = \epsilon \end{align}$$
```
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---