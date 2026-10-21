---
tags:
  - statistics
---
Tags: #Proposition 
Links:

---
-   Proved by: [[Markov's Inequality]]
-   References:
-   Justifications:  
-   Generalizations:
-   Counterexamples: 
```ad-note
title: Theorem
color: 0, 236, 220

<u>Def:</u> Let $X$ be a random variable with mean ([[Expected Value]]) $\mu$ and finite variance $\sigma^2$. Then for any positive k, 

$$P(|X-\mu| < k\sigma) \geq 1 - \frac{1}{k^2}$$
```

Lower Bound probability of this interval
Express the size of interval in units of SD.

The probability that we observe $X$ that is within "k" standard deviations of its mean.

```ad-note
title: Proof
color: 255, 0, 0

Markov's Inequality: For non-negative $x$, $P(x \geq a) \leq \frac{E(x)}{a}$.
$$\begin{align*}P(|X - \mu| < k \sigma) &= P((x-\mu)^2 < k^2\sigma^2) \tag{In the form of Markov's Inequality} \\
&= 1 - P((x-\mu)^2 \geq k^2\sigma^2) \\
&\geq 1 - \frac{1}{k^2}
\end{align*}$$
```



### Example

Based on past data, the average daily number of tech support requests at a local call centre is 115 with a standard deviation of 10 calls.
a.) 

Dist^n info: Missing
We are given: $\mu = 115$, $\sigma = 10$
Let C = random # of daily calls

$$\begin{align*} 
P(100 \leq C \leq 130) &= P(-15 \leq C - 115 \leq 15) \\
&= P(-15 \leq C - \mu \leq 15) \\
&= P(|C-\mu| \leq 15) \\
&= P(|C-\mu| < 16) \\
&= P(|C-\mu| < 1.6\sigma) \end{align*}$$

$$P(|x - \mu| < k\sigma) \geq 1- \frac{1}{k^2}$$

<h6 style="font-weight: normal;">See Also</h6>

---
- [[Markov's Inequality]]
<h6 style="font-weight: normal;">References</h6>

---