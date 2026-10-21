---
tags:
  - math
---
Theorem. $\forall n, p \in \mathbb{Z}, Prime(p) \land p \nmid n \implies \text{gcd}(p, n) = 1$

Proof.
- Let $n, p \in \mathbb{Z}$
- Assume $Prime(p) : p > 1 \land (\forall d \in \mathbb{Z}, d \divides p \implies p = 1 \lor d = p)$ and $p \nmid n : \forall k \in \mathbb{Z}, n \neq pk$
- Prove $1 \divides n \land 1 \divides p \land (\forall k_0 \in \mathbb{Z}, k_0 \divides p \land k_0 \divides n \implies k_0 \leq 1)$
- By assumption, $1 \divides p$
- Let $k = n$, then $n = n \implies n = 1 \cdot k \implies 1 \divides n$
- Let $k_0 \in \mathbb{Z}$. Assume $k_0 \divides p \land k_0 \divides n$. Then since every prime divisor of p is either 1 or itself and since $p \nmid n$, 
- $k_0 \leq 1$
- Thus, $\text{gcd}(p, n) = 1$


