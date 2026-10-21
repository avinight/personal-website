---
tags:
  - math
---
Definitions:
Change of Basis Matrix:

Let $\mathcal{A}$ and $\mathcal{B}$ be bases for $\mathbb{R}^n$. The matrix M is called a *change of basis* matrix (which converts from $\mathcal{A}$ to $\mathcal{B}$) if for all $\vec{x} \in \mathbb{R}^n$
$$M\left[\vec{x}\right]_\mathcal{A} = \left[\vec{x}\right]_\mathcal{B}$$

Linear Transformation in a Basis: 

Let $\mathcal{T} : \mathbb{R}^n \rightarrow \mathbb{R}^n$ be a linear transformation and let $\mathcal{B}$ be a basis for $\mathbb{R}^n$.
The *matrix for $\mathcal{T}$ with respect to basis $\mathcal{B}$*, notated $[\mathcal{T}]_{\mathcal{B}}$ is the $n \times n$ matrix satisfying:

$$\left[\mathcal{T}\vec{x}\right] = \left[\mathcal{T}\right]_{\mathcal{B}}\left[\vec{x}\right]_{\mathcal{B}}$$


Theorem: An $n \times n$ matrix $M$ is invertible if and only if $M$ is a change of basis matrix.
Proof: 
Essentially, we want to show that the matrix M is a matrix that represents the basis C. C is comprised of vectors of the column space of M with respect to the standard basis.

If M is a matrix for the basis C, it is necessarily a change of basis matrix from the standard basis to C.

Since C is a basis for R^n with vectors of the column space of M with respect to the standard basis,

$$M = [[C_1]_\mathcal{E} ... [C_n]_\mathcal{E}]$$

Note that,

$$[\vec{c}_i]_\mathcal{C} = \left\{ \begin{bmatrix} 1 \\ 0 \\ \vdots \\ 0 \end{bmatrix}, \cdots, \begin{bmatrix} 0\\ \vdots \\ 0 \\ 1 \end{bmatrix}\right\}$$

since the vectors are coordinates with respect to the basis C.

Thus we can conclude,

$$M[\vec{c}_i]_\mathcal{C} = C_i = [\vec{c}_i]_\mathcal{E}$$
Similar Matrices:

The matrices A and B are called similar matrices, denoted A ~ B, if A and B represent the same linear transformation but in possibly different bases. Equivalently, A ~ B if there is an invertible matrix X so that
$$A=XBX^{-1}$$

Similar Matrices Proof:
As per computing [T]B from the definition of linear transformation in a basis, I will prove that $\left[\mathcal{T}\right]_{\mathcal{B}} = \left[B \leftarrow \mathcal{E}\right] [\mathcal{T}]_{\mathcal{E}}\left[\mathcal{E} \leftarrow \mathcal{B}\right]$

Note that $\left[\mathcal{T}\right]_{\mathcal{B}}\left[\vec{x}\right]_{\mathcal{B}} = [\mathcal{T}\vec{x}]_{\mathcal{B}}$

and that $\left[\mathcal{T}\right]_{\mathcal{B}} [\mathcal{B} \leftarrow \mathcal{E}] = ([\mathcal{T}]_\mathcal{B}[\vec{e_1}]_\mathcal{B}, [\mathcal{T}]_\mathcal{B}[\vec{e_2}]_\mathcal{B})=([\mathcal{T}\vec{e_1}]_\mathcal{B}, [\mathcal{T}\vec{e_2}]_\mathcal{B})$

We can rewrite this tuple as a matrix:

$$= \left[ \left[[\mathcal{T}\right]_{\mathcal{E}}\left[\vec{e_1}\right]_{\mathcal{E}}]_\mathcal{B}, \left[[\mathcal{T}\right]_{\mathcal{E}}\left[\vec{e_2}\right]_{\mathcal{E}}]_\mathcal{B} \right]$$

Consequently we may rewrite this matrix as [[Linear combination | linear combinations]] of the vectors e1 and e2 in the B basis with coefficients from the linear transformation [T]_E:

$$= [\left[\vec{e_1}\right]_{\mathcal{B}}, \left[\vec{e_2}\right]_{\mathcal{B}}]\left[\mathcal{T}\right]_{\mathcal{E}}$$

Therefore, $$[\mathcal{T}]_\mathcal{B}[\mathcal{B} \leftarrow \mathcal{E}] = [\mathcal{B} \leftarrow \mathcal{E}][\mathcal{T}]_\mathcal{E}$$

and

$$[\mathcal{T}]_\mathcal{B} = [\mathcal{B} \leftarrow \mathcal{E}][\mathcal{T}]_\mathcal{E}[\mathcal{E} \leftarrow \mathcal{B}]$$

Since a change of basis matrix is invertible, $[\mathcal{B} \leftarrow \mathcal{E}]^{-1} = [\mathcal{E} \leftarrow \mathcal{B}]$