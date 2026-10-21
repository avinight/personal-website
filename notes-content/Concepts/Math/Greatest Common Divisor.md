---
tags:
  - math
---
Tags:
Links: [[165-CSC165]]

---
# Greatest Common Divisor

Let $m, n$ be natural numbers which are not both 0. 
GCD of $m, n$ denoted gcd(m, n), is the maximum natural number $d$ such that $d$ divides both $m$ and $n$.

gcd(0, 0) = 0
- makes the domain of gcd operator all possible pairs of natural numbers, since $0 \nmid 0$ else it is undefined.

Let $m, n, k \in \mathbb{N}$, not all of which are 0, and suppose $k = \text{gcd}(n, n)$
$$k | m \land k | n \land (\forall e \in \mathbb{N}, e |m \land e | n \implies e \leq k)$$

k divides m, k divides n, and k is the maximum natural number that divides both m and n.

[[GCD Characterization Theorem]]

[[Characterizations]]

[[Facts about divisibility, primes, and gcd]]