Tags:
Links:

---
# Inner Product

```ad-note 
title: Definition

An **inner product** on $V$ is a function that takes each ordered pair $(u, v)$ of elements of $V$ to a number $(u, v) \in F$ and has the following properties.

1. Positivity
2. Definiteness
3. Additivity in first slot
4. Homogeneity in first slot
	- Linear wrt scalar multiplication.
5. Conjugate symmetry
```

Comes in handy with a complex vector space.


```ad-note
title: Proof of Conjugate Symmetry
color: 255, 0, 0

- $\langle\vec{z}, \vec{w}\rangle_{\mathbb{C}^n} = \overline{\vec{w}, \vec{z}}$
	- $\vec{z} = \begin{bmatrix} z_1 \\ \vdots \\ z_n \end{bmatrix}$, $\vec{w} = \begin{bmatrix} w_1 \\ \vdots \\ w_n \end{bmatrix} \in \mathbb{C}^n$ 
	- $\langle \vec{z}, \vec{w}\rangle_{\mathbb{C}^n} = \sum_{i=1}^n z_i \bar{w_i}$ 
	- $=\overline{\overline{\sum_{i=1}^n z_i \overline{w_i} }} = \overline{\sum_{i=1}^n \overline{z_i \overline{w_i} }}$
	- $=\overline{\sum_{i=1}^n \overline{z_i} \overline{\overline{w_i}}}$
	- $=\overline{\sum_{i=1}^n w_i \overline{z_i}}$
	- $= \overline{\langle \vec{w}, \vec{z} \rangle}_{\mathbb{C}^n}$
```
	
	[[Complex Conjugate]]


Euclidean Inner Product (Permission Dot Product)
- $\langle v, w \rangle_{\mathbb{C}^n} = z_1\bar{w_1} + \cdots + z_n\bar{w_n}$

Norm of C to Norm of C^n using euclidean inner product

Example.
Let $P_n(\R)$ be the vector space of polynomials of degree $\leq n$. Let $[a, b] \subseteq \R$ be a closed interval with $a < b$. Then the formula
$$\langle p, q \rangle = \int_{a}^{b} p(x)q(x)dx$$
defines an inner product on $P_n(\R)$. (This is clearly a symmetric bilinear form. It is positive definite since $\langle p, p \rangle = \int_{b}^{a} p(x)^2dx \geq 0$, with equality if and only if $p = 0$. The same formula defines an inner product on the space of all polynomials.

**Exercise**: Why is the imaginary part skew-symmetric?




<h6 style="font-weight: normal;">See Also</h6>

---
- [[Dot Products and Orthogonality]]
- [[Vector Space]]

<h6 style="font-weight: normal;">References</h6>

---