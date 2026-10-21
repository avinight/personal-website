---
tags:
  - course/csc165
  - computer-science
---
Tags:
Links:

---
# Induction Proofs

Some Divisibility Induction Proofs

3.1) $\forall n \in \mathbb{N}, 8 \divides 9^n -1$
- Inductive Step: 
- Assume $P(n) : 8 \divides 9^n -1$
- Prove $P(n+1)$
- Let $k_1 = 9^n + k_0$
$$\begin{align} 
9^{n + 1} - 1 &= 9 \cdot 9^n - 1 \\
&= 8 \cdot 9^n + 9^n - 1 \\
&= 8 \cdot 9^n + 8k_0 \tag{by I.H.} \\
&= 8(9^n + k_0) \\
&= 8k_1
\end{align}$$

3.2) $\forall n \in \mathbb{N}, 6 \divides 5^{2n} -1$
- Base Case. $n = 0$
- Inductive Step. $P(n) : 6 \divides 5^{2n} -1 \implies P(n + 1)$
	- Assume $P(n)$, Prove $P(n+1)$
	- Let $k_1 = 4 \cdot 5^{2n} + k_0$
	$$\begin{align}5^{2(n + 1)} - 1 &= 5^{2n +2} - 1 \\
	&= 25 \cdot 5^{2n} - 1 \\
	&= 24 \cdot 5^{2n} + 5^{2n} - 1 \\
	&= 24 \cdot 5^{2n} + 6k_0 \tag{by I.H} \\
	&= 6(4 \cdot 5^{2n} + k_0) \\
	&= 6k_1
	\end{align}$$

3.5) $\forall n \in \mathbb{N}, n \geq 1 \implies i \neq j \implies p_i \neq p_j \divides 2^{2^n} - 1$


<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---