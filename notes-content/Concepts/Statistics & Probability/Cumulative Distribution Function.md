---
tags:
  - statistics
---
Tags: #Definition 

---
- Types: 
- Examples: 
- Constructions: 
- Generalizations: 

- Properties: [[Discrete Random Variable]], [[Probability Mass Function]]
- Sufficiencies: 
- Equivalences: 
- Justifications:
```ad-note
title: Definition

<u>Def:</u> The *cumulative distribution function* (CDF) F(x) of a [[Discrete Random Variable]] with [[Probability Mass Function]] $P(x)$ or $f(x)$ is a function that returns the cumulative (total) probability up to and including $X = x$.
$$F(b) = P(X \leq b) = \sum_{x \in \{x \leq b\}} P(X = x)$$

The domain of the CDF is always over the set of real numbers! As such, CDFs are often represented as a piecewise function.
```

## Example
---
$$P(x) = \begin{cases} 0 & (x < 0)\\ 
\frac{1}{6} & (0 \leq x < 1) \implies P(X \leq 0.5) = P(X = 0) = \frac{1}{6} \\
\frac{2}{3} & (1 \leq x < 2) \implies P(X = 0) + P(X = 1) = \frac{1}{6} + \frac{1}{2} = \frac{2}{3} \frac{29}{30} & (2 \leq x < 3) \implies P(X \leq x) = P(X = 0) + P(X = 1) + P(X = 2) \\ 
1 & (x \geq 3) \end{cases}$$




<h6 style="font-weight: normal;">See Also</h6>

---
- [[Chebyshev's Inequality]]
- [[Markov's Inequality]]
<h6 style="font-weight: normal;">References</h6>

---