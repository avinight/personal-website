---
tags:
  - math
---
Tags: #Theorem #Calculus

---
Context: [[Limits]]
```ad-note
title: Theorem
color: 0, 236, 220

Suppose $\ds \lim_{x \to a} f(x) = L$ and $\ds \lim_{x \to a}g(x) = m$

Then,
1) $\ds \lim_{x \to a} (f + g)(x) = L + M$
2) $\ds \lim_{x \to a} (f \cdot g)(x) = L \cdot M$
3) 
```
```ad-note
title: Proof
color: 255, 0, 0
Given any $\epsilon > 0$
$0 < |x - a| < \delta \implies |(f+g)(x) - L - M| < \epsilon$

$$\begin{align*}
|f(x) - L + g(x) - M| &\leq |f(x) - L| + |g(x) - m| \\
&< \epsilon_1 + \epsilon_2 \\
&= \epsilon/2 +\epsilon/2 \\
&= \epsilon
\end{align*}$$
```
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---