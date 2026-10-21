---
tags:
  - math
---
Tags:
Links: [[224 MAT224]]

---
# Diagonalization

Let $V$ be a finite-dimensional vector space, and let $T:V \rightarrow V$ be a linear mapping. $T$ is said to be diagonalizable if there exists a basis of $V$, all of whose vectors are eigenvectors of $T$.

A matrix $A$ is diagonalizable if there exists an invertible matrix $P$ that consists of the eigenvectors of A.

Now, the change of basis intuition is beautiful _(and super important to understand)_, but there's an entirely different way of thinking of diagonalization, a **GEOMETRIC** way, that corresponds to first rotating the eigenvectors of G so that they line up with the axes of the cartesian plane _(that's what M^-1 does)_, then scaling them by their corresponding eigenvalues (which we can do with a diagonal matrix D since we now lined them up with the cartesian plane) and then moving them back into their correct locations _(that's what M does)_!

[[Eigenvectors and Eigenvalues]]

Shears and Rotations are not diagonalizable

Rotations that end up on the real values are diagonalizable
- $\theta = 0, 180, 360$ or any scalar multiple of $\pi$

Eigenspace
- The space spanned by all eigenvectors that have the eigenvalue $\lambda_i$

Geometric Multiplicity
- The dimension of the corresponding eigenspace

Algebraic Multiplicity
- The number of times $\lambda_i$ occurs as the root of a characteristic polynomial.

[[The no new eigenvalue lemma proof]] summarized:

See Also

---
- [[Change of Basis Matrix]]
- [[Reflection Matrix]]
- [[Quadratic Forms]]
