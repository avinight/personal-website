Another way of iterating fast
- Avoid reducing the simulation space
- Split up problem in a way that allows us to exploit parallelism and avoid building large matrices

We should minimize wrt $\mathbf{q}_j$

Potential energy structure
$$V = \sum_{j=0}^{m-1} \text{vol}_j \cdot \psi(F_j(E_j \mathbf{q}))$$

For a single vertex
$$E(\mathbf{q}_j^{i+1}) = \frac{1}{2}(\mathbf{q}_j^{i+1} -\tilde{\mathbf{q}}_j^i)^\top M_{jj}(\mathbf{q}_j^{i+1} - \tilde{\mathbf{q}}_j^i) + p_j^\top(\mathbf{q}_j^{i+1}-\tilde{\mathbf{q}}_j^i) + h^2V_j(\mathbf{q}_j^{i+1})$$
For each vertex, j, minimize the energy. This is fast to solve using Newton's method
Since it only depends on a neighbourhood of j

It is not obvious, but we can do it in parallel.

# Greedy Graph Coloring
- Pick a set of colors
- Order all vertices in the mesh
- Assign vertex first feasible color

## Parallelization
For each color, In parallel, minimize for $j \in \text{color}$ the energy

### Pros and Cons
- Very fast due to parallelized small solves
- No cons

## Information propagation
- How many iterations does it take for a vertex to respond?
	- A lot, The deformation only travels along one edge per iteration


- High resolution geometry and high stiffness exacerbates the issue
- Not a deal breaker because you can tune your parameters and geometry to get reasonable output, but not a black box algorithm as pure as Newton's method



