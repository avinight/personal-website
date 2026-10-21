---
tags:
  - math
---
Tags:
Links: [[223 MAT223]], [[224 MAT224]]

---
# Subspaces

Let V be a vector space and let $W \subseteq V$ be a subset. Then W is a (vector) subspace of V if W is a vector space itself under the operations of vector sum and scalar multiplication from V.

Subspace
- A non-empty subset $W \subseteq \mathbb{R}^3$ $\vec{w}_1, \vec{w}_2 \in W$
	- Vector Addition $+ : W \times W \rightarrow W$$\vec{w}_1 + \vec{w}_2 \in W$
	- Scalar Multiplication
		$\cdot : \mathbb{R} \times W \rightarrow W$
		$r\vec{w} \in W$

[[Subspace-Span Theorem]]

Difference between a subspace and a vector space
- A non-empty subset W of V is a subspace of V if W is itself a vector space with the vector addition and the scalar multiplication in V.
- If axioms hold for V, then they necessarily hold for W. It only requires that it is closed under vector addition and scalar multiplication.

Finite vs. Infinite subspace
- Given a set $S = \{a_1x_1 + \cdots + a_nx_n\}$
- Infinite
	$$\text{span}(S) = \{a_1x_1 + \cdots + a_nx_n \divides a_i \in F, x_i \in V, n \in \mathbb{N}\}$$
- Finite
	$$\text{span}(S) = \{a_1x_1 + \cdots + a_nx_n \divides a_i \in F, x_i \in V\}$$

Set of all polynomials of degree exactly n is not a V.S.
	Proof. Let $f, g \in \{P_n(R) \divides deg = n\}$
	Let $f = x^2 + 5, g = -x^2 + x + 1$
	Then $f + g = x + 6 \notin \{P_n(R) \divides deg = n\}$

See Also

---
- [[Dimension]]
- [[Span]]
- [[Representation in a basis]]
- [[Orientation of a basis]]
- [[Vector Space]]
- [[Basis (linear algebra)]]

References

---
- https://en.wikipedia.org/wiki/Linear_subspace