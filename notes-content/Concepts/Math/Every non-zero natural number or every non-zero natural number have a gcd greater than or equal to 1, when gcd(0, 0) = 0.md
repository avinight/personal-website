---
tags:
  - math
---
Theorem. $\forall n, m \in \mathbb{N}, n \neq 0 \lor m \neq 0 \implies \text{gcd}(n, m) \geq 1$

Proof by contrapositive.
- Let $n, m \in \mathbb{N}$
- Assume $\exists k \in \mathbb{N}, k < 1 \land k \divides m \land k \divides n \land (\forall k_0 \in \mathbb{Z}, k_0 \divides n \land k_0 \divides m \implies k_0 \leq k)$ and that $\text{gcd}(0, 0) = 0$
- The only natural number divisor $k < 1$ is $k = 0$. Since no other divisors are zero, by assumption $m = 0 \land n = 0$.
$\hspace{13cm} \square$