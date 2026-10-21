---
tags:
  - math
---
Tags: #Theorem #Proposition

---
-   Proved by: 
-   References:
-   Justifications:  
-   Generalizations:
-   Counterexamples: 
---

```ad-note
title: Theorem
color: 0, 236, 220

If $f$ is continuous on $[a,b]$, then there is some number $y$ in $[a,b]$ such that $f(y) \geq f(x)$ for all $x$ in $[a, b]$
```

```ad-note
title: Proof
color: 255, 0, 0


```

Piazza Proof:

Define B={f(x)|x∈[a,b]}. (Just like what the prof did in class) And we already proved that sup(B) exists.

Let sup(B)=β.

Let A={x∈[a,b]|f<β on  [a,x]}.

Case 1: f(a) = β. Then A is empty. (We know that f(a) couldn’t be smaller than β) And we get β is in B.

Case 2: If f(a) ≠β, then A is not empty. And since b is an upper bound of A, we know that sup(A) exists.

Let sup(A)=α.

By the same proof as given in our lecture, we get that α>a.

Case 2.1 a < α < b. Then f(α) = β (If not, then Thm 5 gives a contradiction. Or we could just use the same process as in Thm 7-1) Thus, β is in B.

Case 2.2 α = b. (Since b is an upper bound, there is no cases when α > b.)

In this case, f(b) = β (Other cases could be excluded using proof by contradiction, just like what we did in the proof of Thm 7-1). And β is also in B.

Summarising all cases above, we get that β must be in B. i.e.There is y ∈ [a, b] such that f(x) is less than or equal to f(y) for all x ∈ [a,b].

Q.E.D
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---