---
tags:
  - math
---
Tags:
Links:

---
A *prime number* n is a natural number greater than 1 whose only natural number divisors are 1 and the number itself.

By definition:
- $n > 1$

$$\forall d \in \mathbb{N}, d \mid n \implies (d = n \lor d = 1)$$
or
[[Prime Characterization Theorem]]

Checking if a number is prime:
```Python
def is_prime(n: int) -> bool:
    """Precondition n > 1."""
    if n > 1:
        count = 0
        d = 2
        while d < n:
            if n % d == 0:
                count += 1
            d += 1
        return count == 0
    return False
```

```Python
def is_prime2(n: int) -> bool:
	"""Precondition n > 1."""
	if n > 1:
		count = 0
		d = 2
		while d <= (n ** 1/2):
			if n % d == 0:
				count += 1
			d += 1
		return count == 0
	return False
```

Questions
A number n is prime if no prime numbers up to $\sqrt{n}$ are factors of n.
- Assume that no prime number p up to sqrt(n) are factors of n.
- By property [[Composite Numbers#^6cd8c2 | B2]] There is no factor m such that $m \nleq \sqrt{n}$ 
- By property [[Composite Numbers#^6f76b5 | B3]], it is prime.

```Python
def is_prime3(n: int) -> bool:
    """Precondition n > 1."""
    if n == 2:
        return True
    elif n > 2:
        d = 2
        while d <= (n ** 1/2):
            if is_prime3(d) and n % d == 0:
                return False
            d += 1
        return True
    return False
```

Proof of lemma

```Python
def is_prime4(n: int) -> bool:
    """Precondition n > 1."""
    if n == 2:
        return True
    elif n > 2:
        d = 2
        while d <= (n ** 1/2):
            if n % 2 == 0:
                return False
            d += 1
        return True
    return False
```
There is no largest prime [[Proof by Contradiction]]
- find a prime 
	list of primes
	n = p_1 times ... times p_2 + 1
	P_i not divide n for any prime in the list
	n = q
	q_i,...,q_n
	q_i != p_j for some i, j

<h6 style="font-weight: normal;">See Also</h6>

---
- [[Composite Numbers]]

<h6 style="font-weight: normal;">References</h6>

---
- https://en.wikipedia.org/wiki/Prime_number
