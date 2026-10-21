---
tags:
  - course/csc417
  - computer-science
---
How do we build a reduced-order model that's compact and expressive?
- Modal analysis
- Data-driven deformation modes

Modal analysis starts with the Euler-Lagrange equations
$$M\mathbf{\ddot{q}} + \frac{\partial V}{\partial \mathbf{q}} = 0$$

We want to linearize around the rest shape
$$M(\mathbf{q}(0) \ddot{+} \mathbf{u}(t)) + \frac{\partial V(\mathbf{q}(0) + \mathbf{u}(t))}{\partial \mathbf{q}} = 0$$

So that
$$M \ddot(\mathbf{u})(t) + \frac{\partial^2 V}{\partial \mathbf{q}} \mathbf{u}(t)=0$$
So that
$$M \ddot(\mathbf{u})(t) + H\mathbf{u}(t) = 0$$
Which is a linear, homogenous ODE! How can we solve it

We can assume we know the solution.
$$\begin{align*}
\mathbf{u} &= \mathbf{v}e^{\lambda t}\\
\ddot{\mathbf{u}} &= \lambda^2 \mathbf{v}e^{\lambda t}
\end{align*}$$

where $\lambda$ is a complex constant and $\mathbf{v} \in \mathbb{R}^{3n}$ .

We get a generalized eigenvector problem.
$$\lambda^2 M \mathbf{u} + H \mathbf{u} = 0 $$
So a good reduced space is a vector of the $k$ lowest order eigenvectors


# Variational Modal Analysis
$$U^* = \underset{U}{\arg\min}\text{ tr}(U^\top H U)$$
Such that $U^\top M U = I$

# Data-Driven deformation modes

