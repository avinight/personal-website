---
tags:
  - math
---
Tags: #Definition 

---

---
- Types: 
- Examples: [[Continuity on an open interval]], [[Continuity on a closed interval]]
- Constructions: [[Intermediate Value Theorem]], [[Extreme Value Theorem]], [[Local Maximum Theorem]], [[Bounded above Theorem]]
- Generalizations: [[Limits]]

- Properties: [[Composition of functions is continuous]], [[Local Maximum Theorem]]
- Sufficiencies: 
- Equivalences: 
- Justifications:
---
```ad-note 
title: Definition

f is <u>continuous</u> at a iff $$\lim_{x \to a} f(x) = f(a)$$
```

## Properties of Continuity
---
```ad-note
title: Theorem
color: 0, 236, 220

If f and g are continuous at a
1) $f + g$ is continuous at $a$
2) $f \cdot g$ is continuous at $a$
3) $\frac{f}{g}$ is continuous at $a$ provided $g(a) \neq 0$
```

```ad-note
title: Proof
color: 255, 0, 0

$$\lim_{x \to a} f(x) = f(a), \lim_{x \to a} g(x) = g(a)$$

$\lim_{x \to a} (f + g)(x) = f(a) + g(a) = (f + g)(a)$
$\lim_{x \to a} (f \cdot g)(x) = f(a)g(a) = (f \cdot g)(a)$
$\lim_{x \to a} (\frac{f}{g})(x) = \frac{f(a)}{g(a)} = (\frac{f}{g})(a)$
```
<h6 style="font-weight: normal;">See Also</h6>

---
- [[Open and Closed Intervals]]
- [[Intermediate Value Theorem]]
<h6 style="font-weight: normal;">References</h6>

---