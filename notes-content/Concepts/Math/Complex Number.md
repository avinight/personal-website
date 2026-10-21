Tags:
Links: [[224 MAT224]]

---
# Complex Number

$$\mathbb{C} = \{(a, b) \divides a, b \in \mathbb{R}\}$$

The set of _complex numbers_, denoted by $\mathbb{C}$, is the set of ordered pairs of real numbers (a, b) with the operations of addition and multiplication defined by
- $\forall (a, b), (c, d) \in \mathbb{C}$
	$$(a, b) + (c, d) = (a + c, b + d)$$
	$$(a, b)(c, d) = (ac - bd, ad + cb)$$

Does $x^2 + 1$ have a root?
- $x^2 = (-1, 0)$

A complex number squared
- $(0, 1)^2 = (-1, 0)$

Alternative representation
$$\mathbb{C} = \{a + bi \divides a, b \in \mathbb{R}\}$$

where Re(z) is the real number $a$. Im(z) is the real number $b$.

Proof
$$1 := (1, 0)$$
$$i := (0, 1)$$

For some complex number $(a, b) \in \mathbb{C}$
$$(a, b) = (a, 0) + (0, b) = a(1, 0) + b(0, 1) = a + bi$$

Commutative
- (a, b) + (c, d) => (a + c, b + d) by definition of addition over C => (c + a, d + b) since R is a field => (c, d) + (a, b) by definition of addition over C.

Multiplicative Inverse
- Every non-zero complex number has a multiplicative inverse.
- $\forall z \in \mathbb{C}, \exists z^{-1} \in \mathbb{C}, zz^{-1} = (1, 0)$
- Pick $0 \neq z \in \mathbb{C}$
- Note that 
$$(a, b)\frac{(a, -b)}{a^2 + b^2} = (1, 0)$$

### Modulus and Argument

The [[Absolute Value]] of the complex number $z = a + bi$ is the nonnegative real number $\sqrt{a^2 + b^2}$ and is denoted by $|z| = r$

The argument is the angle $\theta$ of the polar coordinate representation of $z$.

$$z = |z| (\cos(\theta) + i \sin(\theta))$$

Notice that if $\theta$ is replaced by $\exists k \in \mathbb{Z}, \theta \pm 2 \pi k$ we have defined the same complex number $z$.

<h6 style="font-weight: normal;">See Also</h6>

---
- [[Complex Conjugate]]
- [[Field (mathematics)]]

<h6 style="font-weight: normal;">References</h6>

---
- https://en.wikipedia.org/wiki/Complex_number