Tags: #Theorem

---
-   Proved by:  [[Continuity]]
-   References: [[Local Maximum Theorem]]
-   Justifications:  
-   Generalizations: [[Bounded above on an interval theorem]]
-   Counterexamples: 
---
```ad-note
title: Theorem
color: 0, 236, 220

L+) If $\lim_{x \to c^+} = f(c)$ and $f(c) > 0$, then $f > 0$ on $[c, c + \delta)$ for some $\delta >0$
```

```ad-note
title: Proof
color: 255, 0, 0

Proof of L+. 
$$ \lim_{x \to c^+}f(x)= f(c)$$
means for any $\epsilon > 0$, there is a $\delta > 0$, such that 
$$0 \leq x - c < \delta \implies |f(x) - f(c)| <\epsilon$$

$|f(x) - f(c)| < \frac{f(c)}{2} \implies f(x) > 0$ for $x \in [c, c + \delta)$

$$\begin{align}
|f(x) - f(c)| &< \epsilon \\
-\epsilon < f(x) - f(c) &< \epsilon \\
f(c) - \epsilon < f(x) &< f(c) + \epsilon \\
\frac{f(c)}{2} &< f(x) < \frac{3f(c)}{2} 
\end{align}$$
```

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---