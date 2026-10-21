Tags:
Links:

---
# Variance or Standard Deviation

- Types: [[Expected Value]]
- Examples: 
- Constructions: 
- Generalizations: 

- Properties: 
- Sufficiencies: 
- Equivalences: 
- Justifications:

Measures of the spread and variability of a random variable. 

Variation, denoted $\sigma^2$
Standard Deviation. denoted $\sigma$ is the **square root of variance**.

```ad-note
title: Definition

The *variance* of $X$ is defined to be 
$$\sigma^2 = V(X) = E[(X-\mu)^2] = \sum_{x\in X}(x-\mu)^2 \cdot P(X=x)$$

Variance caputres the spread in units$^2$. The standard deviation, $\sigma = \sqrt{\text{variance}}$ is a measure of spread in the same units as the random variable $X$.
```
Variance represents volitility.

```ad-note
title: Alternative Method
Calculating Variance of a [[Discrete Random Variable]]:

$\begin{align*} E[(X - \mu)^2] &= E[X^2 - 2X\mu + \mu^2] \\ &= E[X]^2 - 2\mu \cdot E[X] + \mu^2 \\ &= E[X]^2 - 2E[X] + E[X]^2 = E[X^2] - E[X]^2 \end{align*}$

Note: $E[X^2] \neq (E[X])^2$
$$V[X] = E[X^2] = \sum_{x \in X} x^2 \cdot f(x)$$
```

<h6 style="font-weight: normal;">See Also</h6>
---
- [[Cumulative Distribution Function]]

<h6 style="font-weight: normal;">References</h6>
---