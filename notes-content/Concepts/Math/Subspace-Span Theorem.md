---
tags:
  - math
---
Every [[Subspace | Subspace]] is a [[Span]] and every span is a subspace.

(1.3.4) Theorem.
Proof. Span -> Subspace (Theorem 1.3.4)
Apply theorem (1.2.8)

Span(S) is non-empty by definition. 
- Let $x, y \in Span(S)$
- Let $c \in \mathbb{R}$
$$x = a_1x_1 + \ldots + a_nx_n$$ with $a_i \in \mathbb{R}$ and $x_i \in S$
$$y = b_1x_1' + \ldots + b_nx_n'$$ 
$b_i \in \mathbb{R}$ and $x_i' \in S$

For any scalar $c$
$$\begin{align} cx + y &= c(a_1x_1 + \ldots + a_nx_n) + b_1x_1' + \ldots + b_nx_n' \\ &= ca_1x_1 + \ldots + ca_nx_n + b_1x_1' + \ldots + b_nx_n' \end{align}$$

Since this is also a linear combination of vectors in the set S, we have that $cx + y \in Span(S)$. Hence Span(S) is a subspace of V.

See Also

---
- [[Subspace Sum]]
