Tags:
Links: [[165-CSC165]]

---
# Proof by contrapositive
Modus Tollens: Proof by contrapositive

A typical proof of an implication (contrapositive/indirect proof).
- Given statement to prove: $P \implies Q$
	Proof. Assume $\lnot Q$
	[Proof that $\lnot P$ is True.]
	
Prove that for all integers $x$, if $x$ does not divide $x+5$, then $x$ does not divide 5.

Translation.
- $\forall x \in \mathbb{Z}, x \nmid (x + 5) \implies x \nmid 5$

Proof by contrapositive.
Let $x \in \mathbb{Z}$. We will prove the contrapositive statement $x \divides 5 \implies x \divides (x+5)$

Assume that $x \divides 5$.
Meaning, $5 = k_1 x$
Let $k_2 = k_1 + 1$
$5 + x = k_1 x + x$
$5 + x = (k_1 + 1)x$
$x + 5 = k_2 x$

See Also

---
- [[Modus Tollens]]

References
- https://en.wikipedia.org/wiki/Contraposition
- https://en.wikipedia.org/wiki/Proof_by_contrapositive
- <a href=https://math.stackexchange.com/questions/2408729/is-my-proof-correct-proof-n2-is-odd-then-n-is-odd> Odd(n^2) => Odd(n) </a>