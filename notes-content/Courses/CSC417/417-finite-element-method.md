
Yes — here’s a short, clean derivation and the meaning of every piece.

**Setup / notation.** Let the tetrahedron vertices be $X_0,X_1,X_2,X_3\in\mathbb R^3$.  
Define the $3\times3$ matrix of edge vectors from $X_0$:
$$T = \big[\,X_1-X_0\;\; X_2-X_0\;\; X_3-X_0\,\big]$$

Introduce local (affine / barycentric) coordinates $\xi=(\xi_1,\xi_2,\xi_3)^T$ so the physical point $X$ is
$$X = X_0 + T\,\xi$$
The barycentric (linear) shape functions for the four nodes are
$$\phi_1(\xi)=\xi_1,\qquad \phi_2(\xi)=\xi_2,\qquad \phi_3(\xi)=\xi_3,\qquad \phi_0(\xi)=1-\xi_1-\xi_2-\xi_3$$

Write this compactly as

$$\phi(\xi)=\begin{bmatrix}\phi_0\\\phi_1\\\phi_2\\\phi_3\end{bmatrix} = \begin{bmatrix}1-\mathbf{1}^T\xi\\[4pt]\xi\end{bmatrix} = \begin{bmatrix}-\mathbf{1}^T\\[2pt] I_{3}\end{bmatrix}\xi \;+\;\begin{bmatrix}1\\0\\0\\0\end{bmatrix},$$
where $\mathbf{1}^T=(1,1,1)$.
We want $\dfrac{\partial\phi}{\partial X}$ (the derivatives of the shape functions with respect to physical coordinates $X$).

**Chain rule.** Since $\phi$ is expressed as a function of $\xi$, and $\xi$ is a function of $X$ via $\xi=T^{-1}(X-X_0)$,
$$\frac{\partial\phi}{\partial X} = \frac{\partial\phi}{\partial \xi}\,\frac{\partial \xi}{\partial X}.$$
Compute each factor:
- $\dfrac{\partial\phi}{\partial\xi}$ is the $4\times3$ constant matrix coming from $\phi(\xi)=(1-\mathbf1^T\xi,\ \xi)^T$:
$$\frac{\partial\phi}{\partial\xi} = \begin{bmatrix} -\mathbf{1}^T\\[4pt] I_{3} \end{bmatrix} = \begin{bmatrix} -1 & -1 & -1\\[4pt] 1 & 0 & 0\\ 0 & 1 & 0\\ 0 & 0 & 1 \end{bmatrix}.$$
- $\dfrac{\partial\xi}{\partial X}$ is simply $T^{-1}$ (since $\xi=T^{-1}(X-X_0)$).
So multiply:
$$\boxed{\;\frac{\partial\phi}{\partial X} =\begin{bmatrix}-\mathbf{1}^T\\[4pt] I_{3}\end{bmatrix}T^{-1} \;=\; \begin{bmatrix} -\mathbf{1}^T T^{-1}\\[6pt] T^{-1} \end{bmatrix}\;.}$$
**Interpretation / sizes.**
- $\dfrac{\partial\phi}{\partial X}$ is a $4\times3$ matrix.
- Row ii of this matrix is $\nabla_X \phi_i$ (the gradient of shape function $\phi_i$ in physical coordinates).
    - The first row (for $\phi_0$) is $-\mathbf{1}^T T^{-1}$.
        
    - Rows 2–4 (for $\phi_1,\phi_2,\phi_3$) are the rows of $T^{-1}$.
        
**Requirement.** This formula requires $T$ to be invertible (non-degenerate tetrahedron).