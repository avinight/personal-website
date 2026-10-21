---
tags:
  - math
---
$$\forall k \in \mathbb R^{\geq 0}, (k < 1) \implies (\exists x_0 \in \mathbb{R}^{\geq 0}, \forall x \in \mathbb{R}^{\geq 0}, x \geq x_0 \implies (\lfloor x \rfloor)^2 \geq kx^2)$$

Proof. Let $k \in \mathbb{R}^{\geq 0}$ and assume $k < 1$.
- Prove $\exists x_0 \in \mathbb{R}^{\geq 0}, \forall x \in \mathbb{R}^{\geq 0}, x \geq x_0 \implies (\lfloor x \rfloor)^2 \geq kx^2$.
	
	Let $x_0 = \frac{2}{1-k}$ and $x \in \mathbb{R}^{\geq 0}$. Assume $x \geq x_0$.
	
	Prove lemma$\forall k \in \mathbb{R}^{\geq 0}, k < 1 \implies (\forall x \in \mathbb{R}^{\geq 0}, x \geq \frac{2}{1-k} \implies (1-k)x^2 \geq 2x)$
	- Using our assumptions $k \in \mathbb{R}^{\geq 0}$, $k < 1$, and $x \in \mathbb{R}^{\geq 0}$ 
	- Then,
		$$\begin{align}x &\geq \frac{2}{1-k} \\ (1-k)x &\geq 2 \\ (1-k)x^2 &\geq 2x \geq 2\epsilon x \end{align}$$
$\begin{align}(\lfloor x \rfloor)^2 &= (x - \epsilon)^2 \hspace{20mm} \text{by floor fact}\\ &= x^2 - 2\epsilon x + \epsilon ^2 \\ &\geq x^2 - (1-k)x^2 + \epsilon ^2 \hspace{20mm}\text{by lemma}\\ &\geq kx^2 \end{align}$ 
$\hspace{13cm} \square$