---
tags:
  - course/mat257
  - math
---
Tags:

---

We want to generalize the "substitution rule."
1) n-dimensional integrals 
2) Prove it for extended integral, rather than merely for integrals of bounded functions over bounded sets.

This generalized version of substitution rule is called the "Change of Variables" Theorem.
### Partitions of Unity
---
- Requires reformulating definition of extended integral
	- Usually break the set $A$ up into[[257 Rectifiable Sets | compact rectifiable]] sets $C_N$ and taking limit of the integrals $\int_{C_N}f$.
- We now break the function $f$ up into functions $f_N$ and take the limit of the integrals $\int_A f_N$. 

```ad-note
title: Lemma 16.1

Let $Q$ be a rectangle in $\mathbb{R}^n$. There is a $C^{\infty}$ function $\phi : \mathbb{R}^n \to \mathbb{R}$ such that $\phi(x) > 0$ for $x \in \texttt{Int} \space Q$ and $\phi(x) = 0$ otherwise.

```

```ad-note
title: Lemma 16.2

Let $\mathcal{A}$ be a collection of open sets in $\mathbb{R}^n$; let $A$ be their union. Then there exists a countable collection $Q_1, Q_2, ...$ of rectangles contained in $A$ such that:
1) The sets $\texttt{Int} \space Q_i$ cover $A$.
2) Each $Q_i$ is contained in an element of $A$.
3) Each point of $A$ has a neighbourhood that intersects only finitely many of the sets $Q_i$.
```

Proof Questions.
1. Why does Figure 16.2 mean that $C_x$ is a cube contained inside an element in the set $\mathcal{A}$?


```ad-info
title: Definition.

If $\phi : \mathbb{R}^n \to \mathbb{R}$, then the **support** of $\phi$ is defined to be the closure of the set $\{x \mid \phi(x) \neq 0\}$. 

Said differently, the support of $\phi$ is characterized by the property that if $x \not\in \texttt{Support} \space \phi$, then there is some neighbourhood of $x$ on which the function $\phi$ vanished indentically.

```

```ad-note
title: Theorem 16.3

Let $\mathcal{A}$ be a collection of open sets in $\mathbb{R}^n$; let $A$ be their union. There exists a sequence $\phi_1, \phi_2, ...$ of continuous functions $\phi_i : \mathbb{R}^n \to \mathbb{R}$ such that:
	1. $\phi_i(x) \geq 0$, for all $x$.
	2. The set $S_i = \texttt{Support} \space \phi_i$ is contained in $A$.
	3. Each point of A has a neighborhood that intersects only finitely many of the sets $S_i$.
	4. $\sum_{i=0}^{\infty} \phi_i(x) = 1$ for each $x \in A$.
	5. The functions $\phi_i$ are of class $C^{\infty}$
	6. The sets $S_i$ are compact.
	7. For each i, the set $S_i$ is contained in an element of $A$.

```

Proof. 

Dependencies
- Lemma 16.2
- Lemma 16.1 to show that each rectangle has a $C^{\infty}$ function that is positive on $\texttt{Int} \space Q_i$ and zero elsewhere.
- 
Questions
1. Why does the sum converge trivially to 1
2. Why can we just choose $\psi_i$ when its existence is not useful?

```ad-note
title: Lemma 16.4

Let $A$ be open in $\mathbb{R}^n$; let $f:A \to \mathbb{R}$ be continuous. If $f$ vanishes outside the compact subset $C$ of $A$, then the integrals $\int_A f$ and $\int_C f$ exist and are equal.

```
Proof. 

Dependencies: 
- [[257 Improper Integrals#^0e3bb9 |Lemma 15.1]] shows there is a sequence of compact rectifiable sets whose union is $A$.
- Compactness shows there are finitely many sets that cover $C$.
- Theorem 15.2 shows that $f$ is integrable over $A$.

```ad-note
title: Theorem 16.5

Let $A$ be open in $\mathbb{R}^n$; let $f: A \to \mathbb{R}$ be continuous. Let $\{\phi_i\}$ be a partition of unity on $A$ having compact supports. The integral $\int_A f$ exists if and only if the series 
$$\sum_{i=1}^{\infty}[\int_A\phi_i |f|]$$
converges; in this case,
$$\int_A f = \sum_{i=1}^{\infty} [\int_A\phi_i f]$$
Note that the integral $\int_A\phi_i f$ exists and equals the ordinary integral $\int_{S_i}\phi_i f$ (where $S_i = \texttt{Support} \space \phi_i$ ) by the preceding lemma.
```

Proof.

Dependencies
Step 1.
- Compactness of $D$ shows that there is some $M$ for which $\phi_i$ vanishes identically on $D$, since $D$ is covered by finitely many compact supports. If $x$ is not in the support of $\phi_i$ covering $D$, then there is a neighbourhood that vanishes identically. 
- Partition of Unity property shows for every point, there exists a neighbourhood of $x$ that intersects finitely many supports. Take the arbitrary union of all these sets. Then there is a finite union of these sets by compactness. 
- Partition of Unity property shows $$f(x) = \sum_{i=1}^M \phi_i(x)f(x)$$
- Lemma 16.4 is used since the function $\phi_i(x)f(x)$ vanishes outside $D \cup S_i$ .
- $D$ is arbitrary meaning that $f$ is extended integrable over $A$.

Step 2.
- Lemma 16.4 is used. 

### Change of Variables Theorem
---
```ad-note
title: Theorem 17.1 (Substitution Rule)

Let $I = [a, b]$. Let $g: I \to \mathbb{R}$ be a function of class $C^1$, with $g'(x)\neq 0$ for $x \in (a, b)$. Then the set $g(I)$ is a closed interval $J$ with endpoints $g(a)$ and $g(b)$. If $f:J \to \mathbb{R}$ is continuous, then $$\int_{g(a)}^{g(b)}f = \int_a^b (f \circ g)g'$$
or equivalently,
$$\int_J f = \int_I (f \circ g)|g'|$$

```
Proof. 

Dependencies:
- FTC1 shows that the antiderivative exists and is $F$.
- Applying FTC2

Questions:
- Continuity of $g'$ and intermediate value theorem imply $g'(x) > 0$ or $g'(x) <0$.
- MVT applied

```ad-info
title: Definition

Let $A$ be open in $\mathbb{R}^n$. Let $g: A \to \mathbb{R}^n$ be a one-to-one function of class $C^r$, such that $\det Dg(x)\neq 0$ for $x \in A$. Then $g$ is called a **change of variables** in $\mathbb{R}^n$

```
```ad-info
title: Definition

If $A$ and $B$ are open sets in $\mathbb{R}^n$ and if $g: A \to B$ is a one-to-one function carrying $A$ onto $B$ such that both $g$ and $g^{-1}$ are of class $C^r$, then $g$ is called a **diffeomorphism** of class $C^r$.

```

```ad-note
title: Theorem 17.2

Let $g: A \to B$ be a diffeomorphism of open sets in $\mathbb{R}^n$. Let $f: B \to \mathbb{R}$ be a continuous function. Then $f$ is integrable over $B$ if and only if the function $(f \circ g)|\det Dg|$ is integrable over $A$; in this case,
$$\int_B f = \int_A (f \circ g)|\det Dg|.$$

```

### Diffeomorphisms in R^n
---
- We need fundamental properties of diffeomorphisms before proving the change of variables theorem.

Two major results:
- Image of a compact rectifiable set under a diffeomorphism is another compact rectifiable set.
- Any diffeomorphism can be broken up locally into a composite of diffeomorphisms of a special type called "primitive diffeomorphisms"

```ad-note
title: Lemma 18.1

Let $A$ be open in $\mathbb{R}^n$; let $g: A \to \mathbb{R}^n$ be a function of class $C^1$. If the subset $E$ of $A$ has measure zero in $\mathbb{R}^n$, then the set $g(E)$ also has measure zero in $\mathbb{R}^n$.

```

Step 1:
- Why does showing that if Q is a rectangle in Rn, then Q can be covered by finitely many cubes, each of width less than delta suffice?

```ad-note
title: Theorem 18.2

Let $g : A \to B$ be a diffeomorphism of class $C^r$, where $A$ and $B$ are open sets in $\mathbb{R}^n$. Let $D$ be a compact subset of $A$, and let $E = g(D)$.

(a) We have $g(\texttt{Int} \space D) = \texttt{Int} \space E$ and $g(\texttt{Bd} \space D) = \texttt{Bd} \space E$.
(b) If $D$ is rectifiable, so is $E$.
```
Proof.

```ad-note
title: Theorem 18.3

Let $g: A \to B$ be a diffeomorphism of open sets in $\mathbb{R}^n$, where $n \geq 2$. Given $a \in A$, there is a neighbourhood $U_0$ of $a$ contained in $A$, and a sequence of diffeomorphisms of open sets in $\mathbb{R}^n$, $$U_0 \xrightarrow{h_1} U_1 \xrightarrow{h_2} U_2 \rightarrow \cdots \xrightarrow{h_k} U_k$$

such that the composite $h_k \circ \cdots \circ h_2 \circ h_1$ equals $g|_{U_0}$
```

Step 1. 
- $T: \mathbb{R}^n \to \mathbb{R}^n$ is a linear transformation $T(x) = C \cdot x$, where $C$ is a non-singular $n$ by $n$ matrix.
- We show that $T$ factors into a sequence of primitive non-singular linear transformations.
- Use theorem 2.4 to show that $C$ can be factored into elementary matrices. The swapping rows transformation is a sequence of primitive linear transformations.

Step 2.
- Consider the case where $g$ is a translation. $t: \mathbb{R}^n \to \mathbb{R}^n$ is the map $t(x) = x + c$. which is a composite of primitive translations. Since one preserves all except the 1st coordinate and the other preserves the 1st coordinate.

Step 3.
- Consider the case where $a=0, g(0)=0, Dg(0)=I_n$. In this case, $g$ factors locally as a composite of two primitive diffeomorphisms.

### Proof of Change of Variables Theorem
---
The change of variables theorem stated in two lemmas 19.1 and 19.2:
```ad-note
title: Lemma 19.1

Let $g: A \to B$ be a diffeomorphism of open sets in $\mathbb{R}^n$. Then for every continuous function $f:B \to \mathbb{R}$ that is integrable over $B$, the function $(f \circ g)|\det Dg|$ is integrable over $A$, and $$\int_B f = \int_A(f \circ g)|\det Dg|$$

```

Proof. 

Step 1.
- This step shows that if the lemma holds for $g: U \to V$ and $h: V \to W$, then it holds for $h \circ g$.
- the whence clause means for which and the result follows from property of determinant.

Step 2.
- If the lemma holds locally for $g$ and continuous functions $f$ having compact support, then it holds for $g$ and all $f$.
- `(*)` The hard part is showing $\{\phi_i \circ g\}$ is a partition of unity.
- EVT to show $g^{-1}(T_i)$ is compact
- We use `(*)` in Theorem 16.5 to conclude the result.

Step 3.
- Base Case. n = 1. Proved using Theorem 17.1 and 18.2

Step 4.
- Let $n > 1$.
- This step shows that it suffices to prove the lemma for a primitive diffeomorphism $h: U \to V$ of open sets in $\mathbb{R}^n$.
- Use Theorem 18.3, Step 1 and Step 2

Step 5.
- Inductive step. If lemma holds in dimension $n-1$, it holds in dimension $n$.
- 

```ad-note
title: Lemma 19.2

Let $g: A \to B$ be a diffeomorphism of open sets in $\mathbb{R}^n$; let $f: B \to \mathbb{R}$ be continuous. If $(f\circ g)|\det Dg|$ is integrable over $A$, then $f$ is integrable over $B$.

```

### Applications of Change of Variables
---

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- [https://math.stackexchange.com/questions/3953490/exercise-6-on-p-111-in-analysis-on-manifolds-by-james-r-munkres](https://math.stackexchange.com/questions/3953490/exercise-6-on-p-111-in-analysis-on-manifolds-by-james-r-munkres "https://math.stackexchange.com/questions/3953490/exercise-6-on-p-111-in-analysis-on-manifolds-by-james-r-munkres")
- [https://math.stackexchange.com/questions/3437145/infinitely-differentiable-function-with-compact-support-on-mathbbrn-with-g](https://math.stackexchange.com/questions/3437145/infinitely-differentiable-function-with-compact-support-on-mathbbrn-with-g "https://math.stackexchange.com/questions/3437145/infinitely-differentiable-function-with-compact-support-on-mathbbrn-with-g")
- [https://www.youtube.com/watch?v=ngu6fMYJB8E](https://www.youtube.com/watch?v=ngu6fMYJB8E "https://www.youtube.com/watch?v=ngu6fMYJB8E")
- [https://www.quora.com/What-is-the-proof-for-the-volume-of-n-ball](https://www.quora.com/What-is-the-proof-for-the-volume-of-n-ball "https://www.quora.com/What-is-the-proof-for-the-volume-of-n-ball")
- 