Proof by [[Mathematical Induction]]

[[Well-Ordering Principle]]

```ad-note
title: Theorem
color: 0, 236, 220

_Every_ positive integer greater than 1 can be written as a product of prime numbers (or the integer is itself a prime number)
```

Proof by contradiction
Assume the set S is not prime and it is not a product of prime numbers. 
1. $S = \{k \in \mathbb{N} \mid k > 1 \land k \neq pq \text{ for some prime } p, q \in \mathbb{N}\}$
2. Assume S is non-empty, by WOP. Let $t$ be the smallest element in S that is > 1 and not a product of primes.
3. If t is composite, then there exists a factor m with 1 < m < t. Because t is the least element, m must be prime or written as a product of primes. This contradicts that t is not a product of primes.
	
