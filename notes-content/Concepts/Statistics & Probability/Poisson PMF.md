Tags: #Definition

---
- Types:  [[Binomial Distribution]]
- Examples: 
- Constructions: 
- Generalizations: [[Probability Mass Function]]

- Properties: 
- Sufficiencies: 
- Equivalences: 
- Justifications: [[Deriving Poisson PMF]]
```ad-note 
title: Definition

A [[Discrete Random Variable]] X denoting the number of (sometimes rare) events of interest in an interval, with the mean number of occurrences per unit interval denoted by $\lambda$, is *Poisson* distributed if it has the following probability mass function:
$$P(X = x) = \frac{\lambda^x e^{-\lambda}}{x!}
$$
X has expectation $E[X] = \lambda$ and variance $V(X) = \lambda$
```

### Deriving Poisson PMF
---
P(D = d) = ? D = # of shiba sighted in "n" subintervals
$D \sim Bin(n, p = \frac{\lambda}{n}) \implies E(D) = np = \lambda$

$$
\begin{align}
\ds P(D = d) &= \lim_{n \to \infty} nCd \times p^d(1-p)^{n-d} \\
&= \lim_{n \to \infty} \frac{n!}{d!(n-d)!} (\frac{\lambda}{d})^d (1 - \frac{\lambda}{d})^{n-d} \\
&= \frac{\lambda^d}{d!} \lim_{n \to \infty} \frac{n(n-1)...(n-d+1)(n-d)!}{(n-d)!} \frac{1}{n^d}(1- \frac{\lambda}{n})^{n-d} \\
&= \frac{\lambda^d}{d!} \lim_{n \to \infty} \frac{n}{n} \times \frac{n-1}{n} \times ... \times \frac{(n-d+1)}{n}(1 - \frac{\lambda}{n})^{n-d} \\
&= \lim_{n \to \infty}(\frac{\lambda}{n})^{n-d}
\end{align}
$$


Note: $\lambda$ is also called the rate parameter as it describes the average rate of occurrence of the event.

$\ds \lambda$ should always be adjusted for the time interval being considered.
ex. $\ds \lambda = 10$ per day.
Prob. we observe a shiba in an hour? -> Adjust $\lambda$ to be per hr.
$\lambda = 10$ per day $\implies \lambda = \frac{10}{24}$ per hour.

$P(D = 1) = \frac{e^{-\frac{10}{24}}\frac{10}{24}}{1!}$

Poisson distribution is appropriate for discrete random variables that count the number of occurrences in a continuous interval where
- No more than one occurrence can occur simultaneously
- Non-overlapping intervals have occurrences that behave independnetly
- Expected number of occurrences in each fixed time interval is constant

Binomial : nCk p^k (1-p)^{n-k}
n = 10000, p = 0.01 -> $\lambda = 0.01 \times 10000 = 100$

---
#### Example

An area of a forest has on average 6 trees per 100m^2.
- Assumptions for a poisson model seem appropriate for modeling tree distribution in a forest?
	- Two simultaneous trees (two trees occupying the same spot = 0)
	- Could reasonably assume that the number of trees per area are independent.
- Probability of having at least 1 tree in a 100m^2 area
	- Let $T =$ number of trees per 100 m^2
	- $T = Pois(\lambda = 6)$
	- $P(T \geq 1) = 1 - P(T = 0) = 1 - \frac{e^6 6^0}{0!} = 0.9975$
	- There is a 99.75% chance of at least 1 tree in a 100m^2 area.


Expected Value

What is the expected profit for a typical 8 hour workday
- $t =8, R \sim Pois(24)$
- E(R) = 24, V(R) = 24
- $$\begin{align}
E(Y) &= E[85R^2-60(8)] \\
&= E[85R^2 - 480] \\
&= 85E(R^2) - 480 \\
&= 85 x [24 + 24^2] -480 \\
&= 50520
\end{align}$$
V(R) = E(R^2) - E(R)^2

Suppose that you know that in an 8 hour workday, $E(R^4) = 416472$. Determine variance in profit. Can you determine what interval of profits they can expect to earn with at least 75% prob.

$R \sim Pois(24)$
$E(Y) = 50520$
$$\begin{align}
V(Y) = V(85R^2-480) &= 85^2 \times V(R^2) \\ 
&=85^2 \times [416472 - 600^2] \\
&= 408010200
\end{align}$$
$$
\sqrt{V(Y)} = SD(Y) = $20199.26
$$

Q: Do we know distribution of profit Y -> No!
We also E(Y), V(Y)
[[Chebyshev's Inequality]]
$P(|Y-\mu_y| < k \sigma_y) \geq 1 - \frac{1}{k^2}$
so $k = 2$

Long right tail = right sk
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---