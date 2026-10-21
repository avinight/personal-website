---
tags:
  - math
---
Translation.
$\forall f, g, h : \mathbb{N} \rightarrow \mathbb{R}^{\geq 0}, (f \in \mathcal{O}(h) \land g \in \mathcal{O}(h)) \implies f + g \in \mathcal{O}(h)$

Discussion.
We need to assume that $f$ and $g$ are both Big-Oh of $h$, and prove that $f + g$ is also Big-Oh of $h$.

Assuming $f \in \mathcal{O}(h)$ tells us there exist positive real numbers $c_1, n_1$, such that for all $n \in \mathbb{N}$, if $n \geq n_1$ then $f(n) \leq c_q \cdot h(n)$.

There similarly exist $c_2, n_2$, such that $g(n) \leq c_2 \cdot h(n)$ whenever $n \geq n_2$.

Warning: 
- Do not assume $c_1 = c_2$ or $n_1 = n_2$, or any other relationship between these two sets of variables.

Prove that there exists $c, n_0 \in \mathbb{R}^+$ such that for all $n \in \mathbb{N}$ if $n \geq n_0$, then $f(n) + g(n) \leq c \cdot h(n)$

The forms of inequalities we can assume
- $f(n) \leq c_1 h(n)$
- $g(n) \leq c_2 h(n)$
- final inequality

Suggests adding two given inequalities.
- Make sure that both given inequalities hold by choosing n_0 to be large enough, and let $c$ be large enough to take into account both $c_1$ and $c_2$.

Proof. Let $f, g, h : \mathbb{N} \rightarrow \mathbb{R}^{\geq 0}$, and assume $f \in \mathcal{O}(h)$ and $g \in \mathcal{O}(h)$.

By these assumptions, there exist $c_1, c_2, n_1, n_2 \in \mathbb{R}^+$ such that for all $n \in \mathbb{N}$
- if $n \geq n_1$, then $f(n) \leq c_1 \cdot h(n)$
- if $n \geq n_2$, then $g(n) \leq c_2 \cdot h(n)$ 

Prove that there exist $c, n_0 \in \mathbb{R}^+$ such that for all $n \in \mathbb{N}$, if $n \geq n_0$, then $f(n) + g(n) \leq c \cdot h(n)$

Let $n_0 = \text{max}\{n_1, n_2\}$ and $c = c_1 + c_2$.

Let $n \in \mathbb{N}$, and assume that $n \geq n_0$. Prove $f(n) + g(n) \leq c \cdot h(n)$

Since $n_0 \geq n_1$ and $n_0 \geq n_2$, we know that $n$ is greater than or equal to $n_1, n_2$. Then using the Big-Oh assumptions,
$$f(n) \leq c_1 \cdot h(n)$$
$$g(n) \leq c_2 \cdot h(n)$$

Adding these two inequalities together yields
$f(n) + g(n) \leq c_1h(n) + c_2h(n) = (c_1 + c_2)h(n) = c \cdot h(n)$ 
