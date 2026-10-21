---
tags:
  - math
---
Theorem
- For every natural number $n$, there exists $p \in \mathbb{N}$ and bits $b_p, \cdots, b_0 \in \{0, 1\}$ such that $n = \sum_{i=0}^p b_i2^i$

Proof by [[Mathematical Induction]]
- $$\forall m \in \mathbb{N}, \left(\forall n \in \mathbb{N}, n \leq m \implies \left(\exists p \in \mathbb{N}, \exists b_0, b_1, \cdots, b_p \in \{0,1\}, n = \sum_{i=0}^p b_i2^i\right)\right)$$

- Base Case: Let $m=0$
	Let $n \in \mathbb{N}$ and assume that $n \leq m$. Let $p = 0$ and $b_0 = 0$. Then $0 = \sum_{i=0}^p b_i2^i = 0 \times 2^0 = 0$
- Inductive Step: Let $m \in \mathbb{N}$, and assume that $P(m)$ is true, i.e. that every natural number less than or equal to $m$ has a binary representation. Prove $P(m+1)$ is true.
	
	Let $n \in \mathbb{N}$ and assume that $n \leq m + 1$. If $n \leq m$, then by the induction hypothesis $n$ has a binary representation. Assume $n = m + 1$.
	
	Divide rest of proof into cases based on whether $n$ is even or odd.
	
	Case 1. Assume $n$ is even meaning there exists $k \in \mathbb{N}$ such that $n = 2k$
		By a property of divisibility, since $k \divides n$, $k <n$.
		By induction hypothesis there exists $p \in \mathbb{N} \land b_p,\cdots,b_0 \in \{0, 1\}$ such that $$k = \sum_{i=0}^p b_i2^i$$ 
		Then, $$n = 2 \sum_{i=0}^p b_i2^i = \sum_{i=0}^p b_i2^{i+1}$$
		Let $p' = p + 1$, and let $b'_0 = 0$, and for all $i \in \{1, 2, \cdots, p+1\}$, let $b'_i = b_i-1$. Then $$n = \sum_{i=0}^{p'}b'_i2^i$$
	Case 2. Assume $n$ is odd meaning there exists $k \in \mathbb{N}$ such that $n=2k+1$.
		By induction hypothesis there exists $p \in \mathbb{N} \land b_p,\cdots,b_0 \in \{0, 1\}$ such that $$k = \sum_{i=0}^p b_i2^i$$
		Then, $$n = 2\left(\sum_{i=0}^pb_i2^i\right) + 1 =\left(\sum_{i=0}^pb_i2^{i+1}\right) + 1$$
		Let $p' = p+1$ and let $b'_0 = 1$, and for all $i \in \{1, 2, \cdots, p+1\}$, let $b'_i = b_{i-1}$
		Then, $$n = \sum_{i=0}^{p'}b'_i2^i$$