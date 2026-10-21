Tags: #Theorem #Proposition

---
-   Proved by:  [[Continuity]]
-   References:
-   Justifications:  
-   Generalizations:
-   Counterexamples: 
---

```ad-note
title: Theorem
color: 0, 236, 220

Local Theorem: Supposed f is continuous at a and f(a) > 0. Then there is a $\delta > 0$ such that $$f(x) > 0 \text{ on } (a - \delta, a + \delta)$$
```

```ad-note
title: Proof
color: 255, 0, 0

Proof of Local Theorem. 
f is continuous at a means Given any $\epsilon > 0$, there is $\delta > 0$ such that
$$|x - a| < \delta \implies |f(x) - f(a)| <\epsilon
$$
Take $\epsilon = \frac{f(a)}{2}$, $|f(x) - f(a)| < \frac{f(a)}{2} \implies f(x) > 0$
```

Problem 16
[[Local Maximum for right hand continuity]]
```ad-note
title: Lemma
color: 0, 236, 220

L) If $f$ is continuous at c, $f(c) > 0$ then there is $\delta > 0$ such that $f > 0$ on $(c-\delta, c+\delta)$

L-) If $\lim_{x \to c^-} = f(c)$ and $f(c) > 0$, then $f > 0$ on $(c - \delta, c]$ for some $\delta >0$
```
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---