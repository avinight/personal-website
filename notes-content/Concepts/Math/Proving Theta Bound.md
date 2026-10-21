---
tags:
  - math
---
Tags:
Links: <a href='https://piazza.com/class/kjiucttm2wc498?cid=1553'>max function for concrete iterations</a>, [[165-CSC165]]

---
# Proving Theta Bound

When proving <u>Theta Bound</u> what values of n do you care about? Does it matter what happens for small values?

The max is useful here only if you intend to express **exactly** how many iterations are performed, for **every** value of n. For example, when n = 2, the algorithm clearly **cannot** perform n−4 = −2 iterations!

'# of iterations' 0 if n < starting index, n-(starting index) if n > starting index

Examples: 

Prove $2^{\lceil \log_2n \rceil} \in \Theta (n)$
$$\exists c_1, c_2, n_0 \in \mathbb{R}, \forall n \in \mathbb{N}, n \geq n_0 \implies c_1 n \leq 2^{\lceil \log_2n \rceil} \leq c_2 n$$
Let $n_0 = 1$, $c_1 = 1$, and $c_2 = 2$.
Assume that $n \geq n_0$.
Part 1.
Clearly, $$n = n$$ We can conclude, $$n \leq n$$ By the fact that $\forall x \in \mathbb{R}, 0 \leq \lceil x \rceil - x < 1$, $$\log_2 n \leq \log_2 n \leq \lceil \log_2 n \rceil$$ $$\log_2 n \leq \lceil \log_2 n \rceil$$ $$c_1 n \leq 2^{\lceil \log_2n \rceil}$$

Part 2.
Clearly, $$n = n$$ We can conclude, $$n \leq n$$ $$1 + \log_2 n \leq 1 + \log_2 n$$ By the earlier fact since $\lceil \log_2 n \rceil + \log_2 n<1$, $$\lceil \log_2n \rceil < 1 + \log_2 n \leq 1 + \log_2 n$$ $$\lceil \log_2n \rceil \leq \log_2 2 + \log_2 n$$ $$\lceil \log_2n \rceil \leq \log_2 2n$$ $$2^{\lceil \log_2n \rceil} \leq 2n$$ $$2^{\lceil \log_2n \rceil} \leq c_2 n$$