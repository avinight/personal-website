---
tags:
  - math
---
Lemma: Every eigenvector in a matrix A corresponds to one eigenvalue.

1.  Let $\vec{v}$ be a linear combination for the column vectors in matrix A. This vector is an eigenvector with a 'new' eigenvalue $\lambda$.
2.  By definition of eigenvector, $A\vec{v} = \lambda\vec{v}$
3.  Then, $A\vec{v}$ can be written as a linear combination of $\lambda$ multiplied by every vector in the column space of A.
4.  $A\vec{v}$ can also be written as a linear combination of every vector in the column space of A multiplied by those vector's respective eigenvalues.
5.  Equating these two expressions and subtracting $A\vec{v}$ from both sides yields a linear combination that contains a vector from the column space of $A$'s eigenvalue subtracted from the 'new' eigenvalue.
6.  Because at least one $\alpha_i$ is non-zero, the aforementioned expression must be zero.
7.  Thus concludes the 'new' eigenvalue $\lambda$ already exists as an eigenvalue for an eigenvector of the matrix $A$ and is therefore not 'new'.
