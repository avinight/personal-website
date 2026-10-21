---
tags:
  - math
---
Tags: #Theorem

---
-   Proved by: [[Continuity]], [[Bounds]], [[Completeness of the real numbers]]
-   References:
-   Justifications:  
-   Generalizations:
-   Counterexamples: 
---
Global Theorem:
```ad-note
title: Theorem
color: 0, 236, 220

Suppose $f$ is continuous on $[a,b]$ and $f(a) < 0 < f(b)$. Then there is $x$ in $(a, b)$ such that $f(x) = 0$

**Note**: f must be continuous on the endpoints
```
Example
$[a, a] = \{a\}$
$\lim_{x \to a^+} f(x) = f(a) \implies f <  0$ on  $[a, a + \delta)$

```ad-note
title: Proof
color: 255, 0, 0

Let $A = \{x \in [a, b] \mid f < 0 \mbox{ on } [a, x]\}$
- $A \neq \emptyset$ since $a \in A$




If $f(\alpha) > 0$, then $0 < f(x)$ on $(a - \delta, a + \delta)$

$sup(A) \leq \alpha - \delta$
$\alpha = sup(A)$
```
![[IVT (2).png]]

Informal analysis
- Locate the first point where $f(x) = 0$, that is, the smallest $x \in [a,b]$ such that $f(x) = 0$
- To find this point, first consider the set $A$ which contains all numbers $x \in [a,b]$ such that $f$ is negative on $[a, x]$
- In Figure 11, $x$ is such a point, while $x'$ is not. The set $A$ itself is indicated by a heavy line. Since $f$ is negative at $a$, and positive at $b$, the set $A$ contains some points greater than $a$, while all points sufficiently close to $b$ are not in $A$. (We are here using the continuity of $f$ on $[a, b]$, as well as Problem 6-16.)

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---