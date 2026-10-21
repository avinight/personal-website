---
tags:
  - course/csc324
  - computer-science
---

type coercion

Java autoboxing

okay lets start from the beginning. A monad is a monoid in the category of endofunctors. We have to define terms.

Monoid - Object with associative binary operation and identity element.

Category - An object containing 3 math entities: Objects, Morphisms, and an associative composition of morphisms such that for every object in the category there is an identity morphism also in the category.

Functor - A map between two categories associating objects to objects and associates morphisms to morphisms. This functor is identity and composition preserving.

Endofunctor - A functor mapping a category to itself.

So a monad is any object T in the category of endofunctors End(C) for some fixed category C together with 2 natural maps (not in End(C)).

1. eta : 1_C -> T

2. mu : T^2 -> T

satisfying the coherence conditions

mu \circ etaT = mu \circ T eta = 1_T (identity)

mu \circ T mu = mu \circ mu T (associativity)


**Pure function:** 1. The function’s behaviour is exactly determined by the value of its inputs. 
2. The function only returns a value, and does nothing else.