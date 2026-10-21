---
tags:
  - math
---
Tags: #Definition 

---
A natural number n > 1 that is not prime is said to be composite.

Not prime means 
- 
Properties
- A composite number number n has a factor m with 1 < m < n.

Questions
1. Prove that any natural number n > 1 is either prime or it is composite. 
	- Assume $n \leq 1$, then the only natural number is n = 1, which is not prime or composite by definition, but since 1 | n and 1 | 1, n is either prime or composite which is a contradiction.
	- Let n be a natural number > 1, if n is prime, then i know it is either prime or composite. if n is composite, then i know it is either composite or prime. 
[[Fundamental Theorem of Arithmetic]]

B2. Prove that if n is composite, then it has a factor of $1 < m \leq \sqrt{n}$
	- Assume n is composite, meaning that there exists a factor m with 1 < m < n.
	- By definition, $n = mb$ for some integer b.
	- $mb \leq n$
	- $mb \leq \sqrt{n}\sqrt{n} = n$
	- $m \leq \sqrt{n}$ or $b \leq \sqrt{n}$ ^6cd8c2

Lemma
- $$\forall n \in \mathbb{N}, n > 1 \implies \exists d \in \mathbb{N}, Prime(d)$$

B3. Prove that for any composite number, n, has prime divisor $p \leq \sqrt{n}$  ^6f76b5
- Let n be a composite number. By composite number property, $1 < m \leq \sqrt{n}$ for arbitrary factor m. By lemma, every m has a prime divisor p. By transitivity, since $m \divides \sqrt{n}$ and $p \divides m$, $p \divides \sqrt{n}$, thus, $p \leq \sqrt{n}$
	

<h6 style="font-weight: normal;">See Also</h6>

---
- [[Prime Numbers]]

<h6 style="font-weight: normal;">References</h6>

---
- https://en.wikipedia.org/wiki/Composite_number
- https://proofwiki.org/wiki/Composite_Number_has_Prime_Factor_not_Greater_Than_its_Square_Root