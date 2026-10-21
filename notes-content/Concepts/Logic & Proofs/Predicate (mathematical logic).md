Tags:
Links: [[165-CSC165]]

---
# Predicates

Predicates are functions with codomain \{True, False\}
$$P_s : A \rightarrow \{T, F\}$$

These statements depend on variables.
The output to these functions are [[Proposition | propositions]].

Think about a function $f(x)=x$ where $x \in R$. We don't say $f$ itself is a set of all possible $x$ values (i.e., $f=\mathbb{R}$. It is totally wrong!).

## Predicates vs. Sets

A predicate splits a set into two subsets, one where P(x) = True, one where P(x) = False.
$S_p \subseteq A$ is the subset associated with P, 
$$S_p = \{x \in A \divides P(x) = T\}$$

[[Set (mathematics)]]
Subsets and Predicates are equivalent
$$P(x) : x \in S$$
$$F(x) : x \in \{x \in A \divides P(x) = T\} \equiv P(x)$$

Example
$$Even(x) : x \in \{x \in \mathbb{Z} \divides x = 2k \text{ for some } k \in \mathbb{Z}\}$$
$$S_E = \{x \in \mathbb{Z} \divides Even(x) = T\}$$
$$Even_1(x) : x \in S_E$$

[[Rule of inference]]

<h6 style="font-weight: normal;">See Also</h6>

---
- [[First-Order Logic]]
- [[Scope (logic)]]

<h6 style="font-weight: normal;">References</h6>

---
- https://en.wikipedia.org/wiki/Predicate_(mathematical_logic)
- https://math.stackexchange.com/questions/3698944/are-sets-predicates
