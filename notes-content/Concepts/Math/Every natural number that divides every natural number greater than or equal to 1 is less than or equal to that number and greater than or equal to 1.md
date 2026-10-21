---
tags:
  - math
---
Theorem. $\forall x, y \in \mathbb{N}, y \geq 1 \land x \divides y \implies 1 \leq x \leq y$

 
 

- Let $x, y \in \mathbb{N}$.
- Assume $y \geq 1 \land x \divides y$.
- Then by definition of divisibility, $\exists k \in \mathbb{Z}, y = kx$
- Note that if $x = 0, \forall k \in \mathbb{Z}, y \neq kx$
- So $x \geq 1$.
- By assumption $x \divides y \implies x \leq y$
	- Assume $x > y$, then $1 > \frac{y}{x} \notin \mathbb{N}$, therefore $x \nmid y$.
- Thus, $1 \leq x \leq y$


