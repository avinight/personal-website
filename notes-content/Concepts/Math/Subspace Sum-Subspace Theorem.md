(1.3.9) Theorem. Let $W_1$ and $W_2$ be subspaces of a vector space V. Then $W_1 + W_2$ is also a subspace of V.

Proof. 
- $W_1 + W_2$ is non-empty since $W_1$ and $W_2$ are non-empty.
- Let $x, y$ be any two vectors in $W_1 + W_2$
- Let $c \in \mathbb{R}$
- Since $x$ and $y \in W_1 + W_2$, we can write $x = x_1 + x_2, y = y_1 + y_2$, where $x_1, y_1 \in W_1$ and $x_2, y_2 \in W_2$
- Then we have: $$\begin{align} cx + y &= c(x_1 + x_2) + y_1 + y_2 \\ &= (cx_1 + y_1) + (cx_2 + y_2) \end{align}$$
- Since $W_1$ and $W_2$ are subspaces of V, we have $cx_1 + y_1 \in W_1$ and $cx_2 + y_2 \in W_2$.
- Hence by definition, $cx + y \in W_1 + W_2$
- By Theorem (1.2.8), $W_1 + W_2$ is a subspace of V.

See Also

--- 
- [[(1.2.8) Theorem]]