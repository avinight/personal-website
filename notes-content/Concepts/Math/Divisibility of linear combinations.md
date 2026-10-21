---
tags:
  - math
---
Theorem.
$\forall a, b, c \in \mathbb{Z}, (a \divides b \land a \divides c \implies a \divides (b + c))$

Proof.
- Let $a, b, c \in \mathbb{Z}$
- Assume $a \divides b$ and $a \divides c$, which means $b = k_1a$ and $c = k_2a$ for $k_1, k_2 \in \mathbb{Z}$
- Then, we want to show that $(b+c) = k_3a$
- Define $k_3 = k_1 + k_2$ since $k_1 \land k_2$ are integers
	$$b + c = k_1a + k_2a$$
	$$b + c = (k_1 + k_2)a$$
	$$b + c = k_3a$$

Which was what we wanted to show.

Theorem.
$\forall{a, b, c, p, q} \in \mathbb{Z}, (a \divides b \land a \divides c \implies a \divides(bp + cq))$

If you have two multiples of a, and then multiply them by any other two numbers and add the results, the final number must always be a multiple of a.

Proof.
- Let $a, b, c, p, q \in \mathbb{Z}$
- Assume $a \divides b$ and $a \divides c$, which means $b = k_1a$ and $c = k_2a$ for $k_1, k_2 \in \mathbb{Z}$
- Then, we want to show that $(bp + cq) = k_3a$ for some $k_3 \in \mathbb{Z}$
- By assumption, $bp = k_1ap$ and $cq = k_2aq$
- Then, define $k_3 = k_1p + k_2q$ Since $k_1, k_2, p, q$ are integers
- Then,
	$$bp + cq = k_1ap + k_2aq$$
	$$bp + cq = (k_1p + k_2q)a$$
	$$bp + cq = k_3a$$

Which was what we wanted to show.