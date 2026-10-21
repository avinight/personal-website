Tags:
Links: [[223 MAT223]]

---
# Linear Independence

Linear Dependence:
- If LD, then $\vec{v}_i \in \text{span}\{\vec{v}_1,...,\vec{v}_{i-1}, \vec{v}_{i+1},..., \vec{v}_n\}$
- A non-trivial relation $$a_ix_i + \cdots + a_nx_n = 0$$ where the $x_i \in S$, and the $a_i \in \mathbb{R}$ are not all zero (i.e., at least one of the $a_i \neq 0$ )
- the set S is said to be linearly dependent if there exists a linear dependence among the vectors in S.
- $\exists a_1, \ldots, a_m \in F, \exists x_1,\ldots,x_m \in S$ st. $a_1x_1 + \ldots + a_mx_m = \vec{0}$, where at least one of $a_i$'s is non-zero.

Linear Independence
-    If LI, then $\vec{v}_i \notin \text{span}\{\vec{v}_1,...,\vec{v}_{i-1}, \vec{v}_{i+1},..., \vec{v}_n\}$
-    The only linear combination that satisfies the [[Homogenous System]] equation is the trivial linear combination or has a unique solution.
-    A subset S of a vector space V is linearly independent
-    A trivial relation among the vectors of S is an equation $a_1x_2 + \cdots + a_nx_n = 0$ where the $x_i \in S$, and the $a_i \in F$ are not all zero.

A [[Subset]] S of a vector space V is linearly independent if whenever we have $a_i \in \mathbb{R}$ and $x_i \in S$ such that $a_1x_1 + \cdots + a_nx_n$, then $a_i = 0$ for all i.

Let S be a linearly independent subset of a vector space V and let S' be a another subset of V that is contained in S. Then S' is also linearly independent.

Lemma.
- $\{v_1, \cdots, v_n\} \in V$ is L.D. iff $\exists i s.t. v_i \in sp(v_1, \ldots, v_{i-1})$

A system of linear equations is consistent when every row of the matrix corresponding to the system has a pivot.

If $S$ is a linearly independent subset of a vector space V and $S' \subseteq S$
- Any relation on S' will give a relation on S.

Let S be a linearly independent subset of V and let $x \in V$, but $x \notin S$. Then S U {x} is linearly independent if and only if $x \in \text{Span}(S)$

See Also

---
- [[Span]]
- [[Basis (linear algebra)]]

References

---
- https://en.wikipedia.org/wiki/Linear_independence