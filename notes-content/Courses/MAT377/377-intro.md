
Definitions
- indicator function
- linearity of expectation
- countable additivity
- independence
- sample space
- change of variables
- distribution or law
- image measure
- 
=======

# Week 2
---
We went from page 18 -> 47

# Week 4
---

- Variance and 2nd moment

Recall: kth moment X is $\mathbb{E} X^k$.
Defn: $Var(X) = \mathbb{E}(X^2)$.
$$ \begin{align}
Var(X) &= \mathbb{E}(X^2 - 2X\mathbb{E}X +(\mathbb{E}X)^2) \\
&= \mathbb{E}X^2 - 2(\mathbb{E}X)^2 + (\mathbb{E}X)^2\\
&= \mathbb{E}X^2 - (\mathbb{E}X)^2
\end{align}
$$

Note: $\mathbb{E}X^2 < \infty \implies \mathbb{E}|X| < \infty$

$$
\begin{align}
|X| &= |X|(\mathbb{1}_{|X| \leq 1} + \mathbb{1}_{|X| > 1}) \\
&= |X|(\mathbb{1}_{|X|\leq 1} + |X| \mathbb{1}_{|X| > 1}) \\
&\leq 1 + X^2 \\
\mathbb{E}|X| &\leq 1 + X^2
\end{align}
$$

Lemma (Jensen's Inequality). Suppose $\mathbb{E}|X| < \infty$. Let $f$ be a convex function, $\mathbb{E}|f(X)| < \infty$. Then $$ f(\mathbb{E}X) \leq \mathbb{E}f(X) $$when $f$ is concave, inequality is flipped. $-f$ is convex.

Pf. Let $f'(x) be the right derivative of $f$. i.e. $f'(x) = \lim_{h \to 0^+} \frac{f(x+h) - f(x)}{h}$ .
Since $f$ is convex, if we let $\mu = \mathbb{E}X$, then 
$$\begin{align}
f(X) &\geq f'(\mathbb{E}X)(X - \mathbb{E}X) + f(\mathbb{E}X) \\
\mathbb{E}f(X) &\geq f(\mathbb{E}X) + f'(\mathbb{E}X)(\mathbb{E}X - \mathbb{E}X)
\end{align}
$$

Now, let's apply Jensen's for $f(x) = x^2$ => $\mathbb{E} X^2) \leq \mathbb{E}X^2$ => $0 \leq \mathbb{E}X^2 - (\mathbb{E}X)^2 = Var(X)$

$$ \begin{align}Var ( \sum_{i=1}^n X_i) &= \mathbb{E}(\sum_{i=1}^n (X_i - \mathbb{E}X_i))^2 \\
&= \sum_{i,j = 1}^n \mathbb{E}(X_i - \mathbb{E}X_i)(X_j - \mathbb{E}X_j) \\
&= \sum_{i, j = 1}^n Cov(X_i, X_j) \\
Cov(X, Y) &= \mathbb{E}(X - \mathbb{E}X(Y - \mathbb{E}Y)) \\
&= \mathbb{E}(XY - X \mathbb{E}Y - Y \mathbb{E}X + (\mathbb{E}Y)(\mathbb{E}X))
\end{align}$$

For $Cov(X, Y)$ to exist, it is enough to ask that $\mathbb{E}X^2, \mathbb{E}Y^2 < \infty$, since $XY \leq \frac{1}{2}X^2 + \frac{1}{2}Y^2 \iff (X-Y)^2 \leq 0$

Lemma. (Cauchy-Schwarz). 
$$(\mathbb{E}XY)^2 \leq \mathbb{E}X^2 \mathbb{E}Y^2$$
Pf. for $t \in \mathbb{R}$, consider 
$$0 \leq \mathbb{E}(tX - Y)^2 = t^2 \mathbb{E}X^2 - 2t\mathbb{E}XY + \mathbb{E}Y^2 = p(t)$$

$b^2 - 4ac \leq 0$ ignore t variable
$4(\mathbb{E}XY)^2 - 4(\mathbb{E}X^2)(\mathbb{E}Y^2) \leq 0$

If you apply CS to $|X|, |Y|$, 
$$ (\mathbb{E}|XY|)^2 \leq \mathbb{E}X^2(\mathbb{E}Y)^2 $$

If $X, Y$ are indep. $$\mathbb{E}XY = \mathbb{E}X \mathbb{E}Y$$
Hence, $X, Y$ indep => Cov(X, Y) = 0
Defn. If $Cov(X, Y) = 0$, we say $X$ and $Y$ are uncorrelated.

e.g. let \epsilon, Z be indep. consider variables
$$
\begin{align}
\mathbb{P}(\epsilon = \pm 1) = \frac{1}{2} \\
\mathbb{P}(Z = \pm 2) = \frac{1}{4} \\
\mathbb{P}(Z = \pm 3) = \frac{1}{4} 
\end{align}
$$

Let $X = Z, Y = \epsilon Z$. Then, 
$$ \begin{align}
\mathbb{E}XY &= \mathbb{E}\epsilon Z^2 = (\mathbb{E}\epsilon)\mathbb{E}Z^2 = 0 \\
0 &= \mathbb{E}X = \mathbb{E}Y
\end{align} $$
so that $X, Y$ are uncorrelated, but $X, Y$ are NOT independent. Since $|X| = |Y|$, so if I know $X = \pm 2 \implies Y = \pm 2$

$$
\begin{align}
Var(\sum_{i=1}^n Xi) &= \sum_{i, j = 1}^n Cov(X_i, X_j) \\
&= \sum_{i=1}^n Var(X_i) + 2 \sum_{i<j} Cov (X_i, X_j)
\end{align}
$$
If $X_i$'s are uncorrelated, then
$$ Var(\sum_{i=1}^n X_i) = \sum_{i=1}^n Var(X_i) $$
If $X_i$'s are iid, 
$$  Var(\sum_{i=1}^n X_i) = nVar(X_1)  $$

Let $X_1, ..., X_n \sim B(p)$. $S_n = X_1 + ... + X_n \sim B(n, p)$. 
$$Var(S_n) = n Var(X_1) = np(1-p)$$
Recall. (iid := independently and identically distributed)

Lemma (LLN). Let $X_1, ..., X_n$ be iid. Let $X_1, ..., X_n$ be iid. Let $\mu = \mathbb{E}X_1$, which we assume exists. Assume second moment exists (Overkill)
Let $$\bar{X_n} = \frac{1}{n} ( X_1 + \cdots + X_n)$

$$$$\mathbb{P}(|\bar{X_n} - \mu| > \epsilon) \leq \frac{Var(X_1)}{n\epsilon^2}$$
Empirical average converges to my true average!



# Week 6
---




