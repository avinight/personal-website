---
tags:
  - math
---
Tags: #Definition
Links:

---
$$f(x)=
\begin{cases}
0 & x \in \Q\\ \frac{1}{q} &x = \frac{p}{q} \text{ reduced fraction}\end{cases}$$

Continuity
Claim:
for any a, 0 < a < 1, the limit of f near a is l=0

Must show, for any $\epsilon > 0, |f(x) - l| = |f(x)| < \epsilon$ 

Suppose $\epsilon = 1$, since |f(x)|<1, for any x, any \delta > 0 will work

Suppose $\epsilon = \frac{1}{2}$ if  $x \neq \frac{1}{2}$

$|f(x)| < \frac{1}{2}$ if $x \neq \frac{1}{2}$

If $a = \frac{1}{2}$ any $\delta > 0$ works

If $a \neq \frac{1}{2}, \delta = |a - \frac{1}{2}|$

$|x - a| < \delta, \frac{1}{2} \not\in (a - \delta, a + \delta)$

so $|f(x)| \leq \frac{1}{2}$

General Case:
For any $\epsilon > 0$ take $n \in \N$ st $\frac{1}{n} < \epsilon$
When is $\frac{1}{q} = |f(x)| \geq \epsilon$ if $x = \frac{p}{q}$

$\frac{1}{q} \geq \frac{1}{n} \implies n \geq q$

Bad points 
$\frac{1}{n}, \frac{2}{n}, ... , \frac{n-1}{n}$

n < q -> 1/q < 1/n 
Take $\delta$ such that none of them (other than possibly q) lie in $(a - \delta, a + \delta)$

$0 < |x - a| < \delta \implies |f(x)| < \frac{1}{q} < \frac{1}{N} < \epsilon$

<h6 style="font-weight: normal;">See Also</h6>

---
- [[Limits]]
<h6 style="font-weight: normal;">References</h6>

---