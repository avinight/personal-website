Tags: #MOC

---
- Context: [[Statistics MOC]]
- Extensions: 
- Generalizations: 

```ad-note 
title: Definition

In a random experiment with sample space $\Omega$, the *probability* of an event A,  
denoted as P(A) is a function that assigns to event A a numerical value that  
measures the chance that event A will occur.
```
## Probability axioms
---
1) $P(A) \geq 0$
2) $P(\Omega) = 1$
3) For a set of disjoint (i.e [[Mutually exclusive]]) events $A_1, A_2, ..., A_n \in \Omega$,
$$P(\bigcup_{i = 1}^n A_i) = \sum_{i = 1}^n P(A_i)
$$

mutually exclusive \neq independent

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---

# Introduction to Probability

Definitions
	$$ p = \frac{x}{n}$$
	Where X is the sum of the people and n is the total population

Random
- Individual outcomes are uncertain, but there is a structure to how often outcomes occur in a very large number of repetitions.

Probability Distributions
- are mathematical models to describe what happens in the long run with outcomes of random experiments.

Event
- A subset of the possible outcomes of a random experiment.

$$P(\text{E}) = \text{the probability of the event E}$$

To be a valid probability, $P(\text{E})$ must be a number between 0 and 1.
- If P(E) = 1, E occurs
- If P(E) = 0, E doesn't occur

The complement of an event
	$$P(\text{E}^c) = 1 - P(\text{E})$$
    
# Conditional Probability

Notation
	$$P(\text{B}|\text{A}) = \text{Conditional probability of B given A}$$
    
Definition of Conditional Probability
	$$P(\text{B|A}) = \frac{P(\text{A and B})}{P(\text{A})}, P(\text{A}) > 0$$
	A gives us partial information about even of interest which is B
    

![Screenshot 2021-10-08 123848.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/215ca563-bf6f-472c-b195-d44b215f474b/Screenshot_2021-10-08_123848.png)

# Statistical Independence and Multiplication Rules

Two events are independent if
	$$P(\text{A|B})=P(\text{A})$$
    - B doesn't have an effect on the probability of event A
   	$$P(\text{B|A})=P(\text{B})$$
    
A and B are independent if:   
	$$P(\text{A}) \times P(\text{B})=P(\text{A and B})$$
        

# Addition Rules

$$P(\text{A or B}) = P(\text{A}) + P(\text{B})- P(\text{A and B})$$

[](https://math.stackexchange.com/questions/479554/drawer-contains-14-socks-if-i-randomly-pull-2-what-is-the-probability-that-i-w)[https://math.stackexchange.com/questions/479554/drawer-contains-14-socks-if-i-randomly-pull-2-what-is-the-probability-that-i-w](https://math.stackexchange.com/questions/479554/drawer-contains-14-socks-if-i-randomly-pull-2-what-is-the-probability-that-i-w)



