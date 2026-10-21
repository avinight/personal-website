Tags:
Links: [[165-CSC165]]

---
# Modular Arithmetic

Let $a, b, n \in \mathbb{Z}$, with $n \neq 0$. We say that $a$ is congruent to $b$ modulo $n$ if and only if $n | (a - b)$. In this case, we write:
 $$ a \equiv b (\text{mod } n)$$
 
 This definiton captures the idea that $a$ and $b$ have the *same remainder* when divided by $n$
 
 Prove that for all $a, b, c, d, n \in \mathbb{Z}$, with $n \neq 0$, if $a \equiv c (\text{mod } n)$ and $b \equiv d (\text{mod } n)$ then:
 1. $a + b \equiv c + d (\text{mod } n)$
 2. $a - b \equiv c - d (\text{mod } n)$
 3. $ab \equiv cd (\text{mod } n)$
 
 $\forall{a, b, c, d, n} \in \mathbb{Z}, (n \neq 0 \land n | (a-c) \land n|(b-d)) \implies n | ((a-b) - (c-d))$
 
Proof. 
Let $a, b, c, d, n \in \mathbb{N}$, and assume that $n \neq 0, n | (a - c)$, and $n | (b-d)$
 
 By [[Divisibility of linear combinations]], since $n | (a-c)$ and $n | (b-d)$, it divides their difference:
 
 	$$n | (a-c) - (b-d)$$
	$$n | (a-b) - (c-d)$$
 
 