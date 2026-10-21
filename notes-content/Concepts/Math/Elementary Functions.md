Tags:
Links: [[165-CSC165]]

---
# Properties of Big-Oh, Omega, and Theta

Elementary Functions

For all $a, b \in \mathbb{R}^+$, the following statements are true
1. If $a > 1 \land b > 1$, then $\log_a n \in \Theta(\log_b n)$
2. If $a < b$, then $n^a \in \mathcal{O}(n^b) \land n^a \notin \Omega(n^b)$
3. If $a < b$, then $a^n \in \mathcal{O}(b^n) \land a^n \notin \Omega(b^n)$
4. If $a > 1$, then $1 \in \mathcal{O}(\log_a n) \land 1 \notin \Omega(\log_a n)$
5. $\log_a n \in \mathcal{O}(n^b) \land \log_a n \notin \Omega(n^b)$
6. If $b > 1$, then $n^a \in \mathcal{O}(b^n) \land n^a \notin \Omega(b^n)$

Basic properties

Theorem. For all $f : \mathbb{N} \rightarrow \mathbb{R}^{\geq 0}, f \in \Theta(f)$

Theorem. For all $f, g : \mathbb{N} \rightarrow \mathbb{R}^{\geq 0}, g \in \mathcal{O}(f) \iff f \in \Omega(g)$

Theorem. For all $f, g, h : \mathbb{N} \rightarrow \mathbb{R}^{\geq 0}$:
- If $f \in \mathcal{O}(g)$ and $g \in \mathcal{O}(h)$, then $f \in \mathcal{O}(h)$
- If $f \in \Omega(g)$ and $g \in \Omega(h)$, then $f \in \Omega(h)$
- If $f \in \Theta(g)$ and $g \in \Theta(h)$, then $f \in \Theta(h)$

Operations of functions

Let $f, g : \mathbb{N} \rightarrow \mathbb{R}^{\geq 0}$. We can define the sum of $f$ and $g$ as the function $f + g: \mathbb{N} \rightarrow \mathbb{R}^{\geq 0}$ such that,
$$\forall n \in \mathbb{N}, (f+g)(n) = f(n) + g(n)$$

Theorem. For all $f, g, h : \mathbb{N} \rightarrow \mathbb{R}^{\geq 0}$, the following hold:
1. If $f \in \mathcal{O}(h)$ and $g \in \mathcal{O}(h)$, then $f +g \in \mathcal{O}(h)$ [[Theorem 5.5.1 Proof]]
2. If $f \in \Omega (h)$, then $f + g \in \Omega(h)$
3. If $f \in \Theta(h)$ and $g \in \Theta(h)$, then $f + g \in \Theta(h)$