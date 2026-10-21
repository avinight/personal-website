---
tags:
  - math
---
Tags:
Links: [[224 MAT224]]

---
# Vector Space

Let F be a [[Field (mathematics)]].
A (real, non-empty) vector space is a set V over F (whose elements are called vectors) with two operations:

a) an operation called vector addition, which for each pair of vectors $x, y \in V$ produces another vector in $V$ denoted $x + y$, and

b) an operation called multiplication by a scalar (a real number), which for each vector $x \in V$, and each scalar $c \in R$ produces another vector in $V$ denoted $cx$

[[Subspace]]

Properties a vector space must satisfy
1. [[Associative property]] of addition: For all $u, v, w \in V, (u + v) + w = u + (v + w)$. 
2. [[Commutative property]] of addition: For all $u, v \in V, u + v = v + u$.
3. Identity of addition: There exists an element 0 such that for all $v \in V, v + 0 = 0 + v = v$. [[Proof of Additive Identity for vector spaces]]
4. Additive Inverses: For each $v \in V$, there is another element $(-v)$ such that $v + (-v) = 0$.
5. [[Distributivity]] property 1: For all $c \in F$ and $u, v \in V, c(u+v)=cu + cv$.
6. Distributivity property 2: For all $c, d \in F$ and $v \in V, (c+d)v = cv +dv$$
7. Associativity of multiplication: For all $c, d \in F$ and $v \in V, c(dv) = (cd)v$
8. Identity of Multiplication: For all $v \in V, 1v = v$

[[Difference between a field and a vector space]]

Suppose
- $\ds \mathbb{R}^2 = \left\{\begin{pmatrix} a_1 \\ a_2 \end{pmatrix} \mid a_i \in \mathbb{R}\right\}$

- $\begin{pmatrix} a_1 \\ a_2 \end{pmatrix} +' \begin{pmatrix} b_1 \\ b_2 \end{pmatrix} = \begin{pmatrix} 0 \\ a_1 + b_2 \end{pmatrix}$

- $c \cdot \begin{pmatrix} a_1 \\ a_2 \end{pmatrix} = \begin{pmatrix} ca_1 \\ ca_2 \end{pmatrix}$
- Then, $+'$ is not commutative, therefore $\mathbb{R}^2$ is not a vector space.

$(\mathbb{R}^+, +, .)$ is not a subspace of $\mathbb{R}$
$(\mathbb{R}^+, +', .')$ is not a subspace of $\mathbb{R}$

Examples of Vector Spaces:
- $\mathbb{R}^n$
- $\mathcal{P}_n(R) = \{p: R \rightarrow R \divides p(x) = a_nx^n + \cdots + a_0x^0, a_i \in R\}$

<h6 style="font-weight: normal;">See Also</h6>

---
- [[Span]]
- [[Subspace]]
- [[Axiom Uniqueness Proposition]]

<h6 style="font-weight: normal;">References</h6>

---
- https://en.wikipedia.org/wiki/Vector_space
- https://en.wikipedia.org/wiki/Dimension_(vector_space)
- https://math.stackexchange.com/questions/969720/what-is-the-main-difference-between-a-vector-space-and-a-field