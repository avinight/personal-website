---
tags:
  - math
---
Tags:

---
### Trig functions

We define angles and area in this chapter

The definition of $\pi$ is stated as follows,
$$\pi = 2 \int_{-1}^{1} (\sqrt{1 - x^2} dx)$$
It is continuous and integrable.

## Angles and Area

- Fractions of area = angle
- $Area(x) = \frac{\theta}{2}$

Writing $x$ as a function of $\theta$ is cosine

Area function:
$$[0, \frac{\pi}{2}] \to\frac{\theta}{2}$$
x
$$[-1, 1] \to \cos(\theta)$$

Assuming $x > 0$. $P = (x, \sqrt{1 - x^2})$, this defines area as,
$$A(x) = \frac{1}{2} x \sqrt{1 - x^2} + \int_{x}^{1} (\sqrt{1 - t^2} dt)$$
Definition of area is literally the integral.

Assuming $x < 0$.  $\frac{1}{2} |x|\sqrt{1 - x^2}$ is the area I want to remove.
$$A(x) = \int_{x}^{1} (\sqrt{1 - t^2} dt) + \frac{1}{2} x \sqrt{1 - x^2}$$
so $A(x)$ is ok for $x \in [-1. 1]$
$$\begin{align}
A’(x) &= \frac{1}{2} \sqrt{1 - x^2} + \frac{1}{2} x \frac{1}{2} \cdot \frac{1}{\sqrt{1 - x^2}}(-2x) - \sqrt{1 - x^2} \\
&= \frac{1}{2} \cdot \frac{1 - x^2) - x^2 - (1 - x^2)}{\sqrt{1 - x^2}} \\
&= -\frac{1}{2}\frac{1}{\sqrt{1 - x^2}} \tag{$A(x)$ diff. on $(-1, 1)$ and $A’(x) < 0$}
\end{align}$$
Define. on $[-1, 1]$. A has an inverse function.. 2A…
$$A(\cos(\theta)) = \frac{\theta}{2}$$
$$(2A)(\cos(\theta)) = \theta$$
Is the derivative defined in terms of integral?
- $\cos(0) = 1$
- $\cos(\pi/2) = 0$ 
- $\cos(pi) = -1$

continuing to sweep to extend the function cos underline to cosine that we want
$$\frac{\pi}{2} + A(-x)$$


<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- https://math.stackexchange.com/questions/3637383/intuition-behind-showing-if-f-f-0-and-if-f0-a-and-f0-b-then-f