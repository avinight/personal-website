---
tags:
  - math
---
Tags: #Definition 

---
Cartesian Coordinates
![[Images/157/Equation For Ellipse.png]]

$$\frac{x^2}{a^2} + \frac{y^2}{b^2} = 1
$$

Deriving the Polar Coordinates

$2a$ is the sum of the distances to the foci.

The distance from $r$ from $(x,y)$ to $O$ is given by
$$r^2 = x^2 + y^2 \tag{1}
$$
By assumption, the distance from $(x, y)$ to $f$ is $2a - r$, hence
$$(2a - r)^2 = (x - [2\epsilon a])^2 + y^2
$$
or 
$$ 4a^2 - 4ar + r^2 = x^2 - 4\epsilon ax + 4\epsilon^2a^2 + y^2 \tag{2}
$$
Subtracting (1) from (2) and dividing by 4a
$$a - r = \epsilon x + \epsilon^2a
$$
$$\begin{align}
r &= a - \epsilon x - \epsilon^2a \\
&=(1-\epsilon^2)a -\epsilon x
\end{align} 
$$
writing it as
$$ \begin{align}
r &= \Lambda - \epsilon x &\text{for } \Lambda = (1-\epsilon^2)a \tag{3}
\end{align} 
$$
Substituting $r \cos(\theta)$ for $x$, we have 
$$\begin{align}
r &= \Lambda - \epsilon r \cos \theta \\
r(1 - \epsilon\cos \theta) &= \Lambda
\end{align} 
$$
Thus,
$$r = \frac{\Lambda}{1 - \epsilon \cos \theta}
$$
<h6 style="font-weight: normal;">See Also</h6>

---
- [[Equation of Hyperbola]]
<h6 style="font-weight: normal;">References</h6>

---