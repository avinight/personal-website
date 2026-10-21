Theorem.
There are infinitely many primes.

Proof.
Assume that the statement is false. 
There exists a finite number of primes. 
Let $k \in \mathbb{N}$ be the number of primes
Let $p_1, \cdots, p_k$ be the prime numbers

Q will be "For all $n \in \mathbb{N}$, n is prime iff $n$ is one of $\{p_1, \cdots, p_k\}$." Q is True because of our assumption that there are a finite number of primes, and definitions of $k$ and $p_1,...p_k$.

Q will be False

$$P = 1 + \prod_{i=1}^k p_i = 1 + p_1 \times \cdots \times p_k$$

There must be some prime p that divides P because P>1. But $p \notin \{p_1,\cdots,p_k\}$ because otherwise p would divide $P - p_1 \times \cdots \times p_k = 1$ and no prime can divide 1. So then p is a prime that is not one of $\{p_1,\cdots,p_k\}$, and so Q is false.
