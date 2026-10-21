(1.1.6) Proposition

a) the zero vector 0 is unique

Proof.
- Suppose we had two vectors, 0 and 0', both of which satisfy axiom 3 in the definition. Then, 0 + 0' = 0, since 0' is an additive identity.
- 0 + 0' = 0' + 0 = 0', since addition is commutative and 0 is an additive identity. Hence 0 = 0', or there is only one additive identity in V.

b) for all $x \in V, 0x = 0$

Proof.
- We have 0x - (0 + 0)x = 0x + 0x, by axiom 6. Hence if we add the inverse of 0x to both sides, we obtain 0 = 0x, as claimed.

c) For each $x \in V$, the additive inverse $-x$ is unique.

Proof.
- Given x \in V, if -x and (-x)' are two additive inverses of x, then on one hand we have $$x + -x + (-x)' = (x + -x) + (-x)' = 0 + (-x)' = (-x)'$$ by axioms 1, 4, 3
- On the other hand, axiom 2 shows us: $$x + -x + (-x)' = x + (-x)' + -x = (x + (-x)') + -x = 0 + -x = -x$$
- Hence $-x = (-x)'$, and the additive inverse of x is unique.

d) $\forall x \in V$, and all $c \in \mathbb{R}, (-c)x = -(cx)$

Proof.
- We have $cx + (-c)x = (c + -c)x = 0x = 0 by axiom 6 and part b. 
- Hence (-c)x also serves as an additive inverse for the vector cx. By part c, therefore, we must have (-c)x = -(cx)

See Also

---
- [[Uniqueness Quantification]]