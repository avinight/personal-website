Tags:
Links: [[165-CSC165]], [[Propositional logic]]

---
# Material Conditional

[[Modus Ponens]]

Implication

A typical proof for an implication.
- Given statement to prove: $P \implies Q$
	Assume P.
	[Proof that Q is True]

Examples
1. if it rains, then I bring my umbrella 
	- gives expectation in case of rain, but not if there is no rain.
	- rain => umbrella
2. if you eat your veggies, then you can have dessert.
	- implies expectations under both situations (eat your veggies) and (do not eat your veggies)
	- veggies <=> dessert

[[Truth Table]]

$$
\begin{array}{|c|c|c|}
  \hline
  p & q & p \implies q\\
  \hline
  T & T & T \\
  \hline 
  T & F & F \\
  \hline 
  F & T & T \\
  \hline 
  F & F & T \\
  \hline 
\end{array}
$$

Insights
- Given a non-strict inequality: $n \leq m$ (less than OR equal to), $n < m$ satisfies the hypothesis.
- Expresses the word "condition" that ignores all other numbers, which do not satisfy the condition.
- Sometimes conditions can be met by either using an implication or changing the domain over which we're quantifying.

<h6 style="font-weight: normal;">See Also</h6>

---
- [[Logical Biconditional]]
- [[Contraposition]]
- [[Vacuous Truth]]

<h6 style="font-weight: normal;">References</h6>

---
- https://en.wikipedia.org/wiki/Material_conditional
- https://en.wikipedia.org/wiki/Material_implication_(rule_of_inference)