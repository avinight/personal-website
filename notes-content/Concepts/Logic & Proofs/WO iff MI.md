---
tags:
  - logic
mathLink: auto
---
Tags:
Links:

---
# Well-Ordering Principle iff Mathematical induction
```ad-note
title: Proof
color: 255,0,0
Proof. ' -> ' Let $A \subset \N$. Suppose not. Assume WO and not MI. 

That is every non-empty subset of N has a least element k_0 and 
1) 1 is in A
2) k + 1 is in A if k is in A
3) $A \neq \N$


Let $B = \{k \mid k \not \in A\}$

Since $A \neq \N$ or $1 \in A$, $B$ is non-empty. Thus, it has a least element k_0. 

$k_0 - 1$ not in $B$, therefore it is in A. 

$k_0 - 1$ is in A implies $k_0$ is in A.

but $k_0 \in B$ and $k_0 \in A$. Contradiction.

Proof. ' <- ' Let $A \subset \N$. Suppose not. Assume MI and not WO.

That is, whenever 
1) 1 is in A
2) k + 1 is in A if k is in A

Then, $A = \N$ and A is non-empty and does not have a least element k_0.

Define $B = \{k \mid k = 1,...,n \not \in A\}$. 

1 is in B. If 1 is in A, k_0 = 1. But $k_0 \not \in A$. Contradiction.

If k not in A and k + 1 is in A. $k_0 = k + 1$. But $k_0 \not \in A$. Contradiction.

So $B = \N$. Thus A is empty and A is non-empty. Contradiction.
$\tag{\blacklozenge}$
```









<h6 style="font-weight: normal;">See Also</h6>

---
- [[Mathematical Induction]]
- [[Well-Ordering Principle]]

<h6 style="font-weight: normal;">References</h6>

---