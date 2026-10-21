---
tags:
  - logic
---
Tags:
Links: [[165-CSC165]], [[246 MAT246]]

---
# Mathematical Induction

```ad-note
title: Definition

For any set $A \subset \N$. If 
1) 1 is in $A$
2) $k + 1$ is in $A$ whenever $k$ is in $A$

Then, $A = \N$
```
Typical structure of a proof by induction

- Given statement to prove: $\forall n \in \mathbb{N}, P(n)$
	Proof. We prove this by induction on $n$.
	Base Case: Let $n=0$.

	[Proof that $P(0)$ is True.]

	Inductive Step: Let $k \in \mathbb{N}$, and assume that $P(k)$ is true. (The assumption that $P(k)$ is true is called the induction hypothesis.)

	[Proof that $P(k + 1)$ is True.]
	
# Complete Induction
```ad-note
title: Definition

For any set $A \subset \N$. If
1) 1 is in A
2) $k + 1$ is in A whenever $1,...,n$ is in A

Then, $A = \N$
```
Proof Structure.
1) Base Case
2) Assume S(k) for all $k \leq n$ for some n
3) Prove S(k) for all $k \leq n$ for some $n \implies S(k + 1)$
# Induction on Sets

See [[Set (mathematics)]]

Every set has a simple corresponding natural number, its size

Given a set of size $k + 1$, split it into a single (special) element and another set of size k.
Let $S' = \{s_1, s_2, \cdots, s_k\}$, so that $S = S' \cup \{S_{k +1}\}$

Induction hypothesis only works for sets of size k.
[[Fundamental Theorem of Arithmetic]]

Examples
- [[CSC165 Exercise 3]]
<h6 style="font-weight: normal;">See Also</h6>

---
- [[Recursion]]

<h6 style="font-weight: normal;">External Links</h6>

---
- https://en.wikipedia.org/wiki/Mathematical_induction
