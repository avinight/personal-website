---
tags:
  - logic
---
Tags:
Links: [[165-CSC165]]

---
# Universal Proof

A typical proof of a universal

- Given statement to prove: $\forall x \in S, P(x).
	Proof. Let $x \in S$. That is, let $x$ be an arbitrary element of $S$.
	[Proof that $P(x)$ is True].

Universal Instantiation: Universally-quantified statement.
- If we already know a universal like $\forall x \in S, P(x)$, and we have a variable $y$ whose value is an element of the domain $S$, then we can conclude that $P(y)$ must be true.
	In a proof:
	- Because we know that $y \in \mathbb{N}$ and that $\forall x \in N, x^2 + 5x + 4$ is not prime, we can conclue that $y^2 +5y + 4$ is not prime.