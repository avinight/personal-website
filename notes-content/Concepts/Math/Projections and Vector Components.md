---
tags:
  - math
---
Tags:
Links: [[223 MAT223]], [[Dot Products and Orthogonality]], [[Double Angle Identities]]

---
# Projections and Vector Components

A projection is a transformation that takes an input and maps it onto the closest point in a set of outputs.
- Let X be a set, $\text{proj}_X \vec{v}$ is the closest point in X to $\vec{v}$.

There are two ways to compute a projection:

Minimizing Distance
- Geometrically, we manipulate the parameter t on the line to minimize the distance between it and the point.

Normal Vector Fact
- Geometrically, we use the parameter t to fix the projection onto the line. If not, then our projection will be any vector orthogonal to our line. 

- $(\vec{v}-\text{proj}_{\ell}\vec{v})$ is a normal vector to $\ell$.

[[Unit Vectors]]

Orthogonal Projections are projections that have a vector component which is orthogonal to another vector. These types of projections are closely related to vector components.

The matrix of an orthogonal projection is represented:

$$A(A^TA)^{-1}A^T$$

Vector Components
- Let $\vec{u}, \vec{v} \neq 0$ be vectors. $\text{vcomp}_{\vec{v}} \vec{u}$ is a vector in the direction of $\vec{v}$ and $\vec{u} - \text{vcomp}_{\vec{v}} \vec{u}$ is orthogonal to $\vec{v}$

Be careful that projection is a point
$\left\{\begin{bmatrix} -1 \\ 1 \\ 0 \end{bmatrix}\right\} \neq \text{span} \left\{\begin{bmatrix} -1 \\ 1 \\ 0 \end{bmatrix}\right\}$ 
