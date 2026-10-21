Tags: #Definition 

---
- Types: 
- Examples: 
- Constructions: [[Variance]]
- Generalizations: 

- Properties: 
- Sufficiencies: 
- Equivalences: 
- Justifications:
---
Intuition: The theoretical average. If a random experiment were to be conducted n times, then as $n \to \infty$ then the *average of outcomes* converges to the expected value. This is often denoted as $\mu$.
```ad-note
title: Definition

The *expected value* of a discrete random quantity $X$ is defined to be:
$$\mu = E(X) = \sum_{x\in X}x \cdot P(X=x)$$

For a given transformation of $X, g(X)$, then $E[g(X)]$ can be found by:
$$E[g(X)] = \sum_{x\in X}g(x) \cdot P(X=x)$$

**NOTE:** $E[g(X)] \neq g(E(X))$ except when $g(X)$ is a linear transformation.
```

<h6 style="font-weight: normal;">See Also</h6>
---
- [[Properties of Expectation]]


<h6 style="font-weight: normal;">References</h6>

---