Tags:
Links: [[165-CSC165]]

---
# Simplifying negated formulas

$\lnot(\lnot p)$ becomes $p$
[[De Morgan's Laws]]
$\lnot(p \implies q)$ becomes $p \land \lnot q$
$\lnot(p \iff q)$ becomes $(p \land \lnot q) \lor (\lnot p \land q)$
$\lnot(\exists x \in S, P(x))$ becomes $\forall x \in S, \lnot P(x)$
$\lnot(\forall x \in S, P(x))$ becomes $\exists x \in S, \lnot P(x)$