(1.3.8) Proposition. Let $W_1 = Span(S_1)$ and $W_2 = Span(S_2)$ be subspace of a vector space V.

Then $W_1 + W_2 = Span(S_1 \cup S_2)$

Proof. Show that each set is contained in the other.

- Let $v \in W_1 + W_2$. 
- Then $v = v_1 + v_2$, where 
	- $v_1 \in W_1$
	- $v_2 \in W_2$.
- Since $W_1 = Span(S_1)$, we can write $v_1 = a_1x_1 + \cdots + a_mx_m$, where each 
	- $x_i \in  S_1$
	- $a_i \in \mathbb{R}$
- Similarly, $v_2 = b_1y_1 + \cdots + b_ny_n$ where each
	- $y_i \in S_2$
	- $b_i \in \mathbb{R}$
- Hence we have $$v = a_1x_1 + \cdots + a_mx_m + b_1y_1 + \cdots + b_ny_n$$
- This is a linear combination of vectors that are either in $S_1$ or $S_2$. Hence $v \in Span(S_1 \cup S_2)$
- Since this is true for all such v, $W_1 + W_2 \subseteq Span(S_1 \cup S_2)$


Conversely,
$Span(S_1 \cup S_2) \subseteq W_1 + W_2$
- if $v \in Span(S_1 \cup S_2)$, then $v = c_1z_1 + \cdots + c_lz_l$, where each
	- $z_k \in S_1 \cup S_2$
	- $c_k \in \mathbb{R}$
- Since $z_k$ is in either s1 or s2, we can rename the vectors and regrouping the terms$$v = a_1x_1 + \cdots + a_mx_m + b_1y_1 + \cdots + b_ny_n$$ where
	- $x_i \in S_1$
	- $y_i \in S_2$
- v is rewritten as the sum of a vector in W_1 and a vector in W_2, so $v \in W_1 + W_2$
- Since this is true for all $v \in Span(S_1 \cup S_2)$, we have $Span(S_1 \cup S_2) \subseteq W_1 + W_2$

See Also

---
- [[Subspace Sum]]
- [[Subspace Sum-Subspace Theorem]]

