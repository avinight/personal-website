Tags: #Proposition

---
-   Proved by:  [[Expected Value]]
-   References: [[Chebyshev's Inequality]]
-   Justifications:  
-   Generalizations:
-   Counterexamples: 

```ad-note
title: Theorem
color: 0, 236, 220

Let $X$ be a non-negative random variable with mean E(X). Then for some
constant $a>0$:
$$P(X \geq a) \leq \frac{E(x)}{a}$$
```
Which only relies on $E(x)$

```ad-note
title: Proof
color: 255, 0, 0

We know $$\begin{align}
E(X) &= \sum_{x \in X}x \cdot P(X = x) \\
&= \sum_{x < a}x \cdot P(X = x) + \sum_{x \geq a}x \cdot P(X = x)
\end{align}$$

$X$ is non-negative random variable, so each term $\geq 0$
$$\begin{align}
&\geq \sum_{x \geq a}x \cdot P(X = x) \\
&\geq \sum_{x \geq a}a \cdot P(X = x) \\
&=a \sum_{x \geq a} P(X = x) \\
&= a P(X \geq a)
\end{align}
$$

Thus $E(x) \geq a P(X \geq a)$. Hence $\frac{E(x)}{a} \geq P(X \geq a)$
```


<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---