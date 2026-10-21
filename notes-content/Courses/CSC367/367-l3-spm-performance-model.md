Using a simple model of memory to optimize
- Assume just 2 levels in the hierarchy, fast and slow
- Assume an element is a float and is equal to word
- All data is initially in slow memory
- Cache lines size is one word
	- ie. we don't model spatial locality
	- ie. row-major and column major layouts are equivalent

We define the following terms:
- m = number of memory elements (words) moved between fast and slow memory
- t_m = time per slow memory operation
- f = number of arithmetic operations
- t_f = time per arithmetic operation << t_m
- q = f / m average number of flops per slow memory access
	- Computational intensity: q = f/m

Minimum possible time = f * t_f when all data in fast memory
Actual time: $$f * t_f + m * t_m = f * t_f * (1 + \frac{t_m}{t_f} * \frac{1}{q})$$
Larger q means time closer to minimum f * t_f
- $q \geq\frac{t_m}{t_f}$ needed to get at least half of peak speed
- Speed is inverse of time to peak speed is $\frac{1}{f \cdot t_f}$

```python
# {implements y = y + A*x}
for i = 1:n
	for j = 1:n
		y(i) = y(i) + A(i, j) * x(j)
```

Assumptions: vectors x and y, and one row of A, all fit in fast memory

```python
# {read x(1:n) into fast memory} Needing n memory references
# {read y(1:n) into fast memory} Needing n memory references
for i = 1:n
	# {read row i of A into fast memory} Needing n memory references, but there is a loop so we do n^2 references
	for j = 1:n
		y(i) = y(i) + A(i, j) * x(j)
# {write y(1:n) back to slow memory} Needing n memory references
```

m = number of slow memory references = $3n + n^2$
f = number of arithmetic operations = $2n^2$
Matrix-vector multiplication limited by slow memory speed.

- Examples of some architectures and their machine balance
- So the computational intensity of 2 in matrix-vector multiply means that we can not get close to half peak of these machines: Matrix-Vector Multiplication is a **_memory bound operation!_**

Naive Matrix Multiply
Assumptions: all data fit in fast memory (ideal case)
```python
# {implements C = C + A * B}
for i = 1:n
	for j = 1:n
		for k = 1:n
			C(i, j) = C(i, j) + A(i, k) * B(k, j)
```
- Algorithm has $2n^3 = \mathcal{O}(n^3)$ flops
- We would only make $4n^2$ memory references because you only need to read each matrix once from slow memory and then it sticks around in fast memory
- q is potentially as large as $\mathcal{O}(n)$

```python
# {implements C = C + A * B}
for i = 1:n
	# { read row i of A into fast memory } N^2 memory references
	for j = 1:n
		# { read C(i, j) into fast memory } N^2 memory references
		# { read column j of B into fast memory } N^3 memory references
		for k = 1:n
			C(i, j) = C(i, j) + A(i, k) * B(k, j)
		# { write C(i, j) back to slow memory } N^2 memory references
```

- m = n * (n + n ( 1 + n + 1 )) = n^3 + 3n^2 
- m = n^3 + n^2 + 2n^2 

# Blocked ( Tiled ) Matrix Multiply

Consider A, B, C to be NxN matrices of bxb subblocks where $b = n / N$ is called the block size

```python
for i = 1:N
	for j = 1:N
		# { read block C(i, j) into fast memory }
		for k = 1:N
			# { read block A(i, k) into fast memory }
			# { read block B(k, j) into fast memory }
			C(i, j) = C(i, j) + A(i, k) * B(k, j) # { do a matmul on blocks }
	# { write block C(i, j) back to slow memory }
```

$$ m = N \cdot N \left( \left(\frac{n}{N}\right)^2 + N \cdot \left(\left(\frac{n}{N}\right)^2 + \left(\frac{n}{N}\right)^2\right) + \left(\frac{n}{N}\right)^2 \right) = (2N + 2)n^2$$
If initially we assume each matrix as N by N elements (the blocks are each one element) then B and A each get read N times, and C is read/written 2 times. Since each element/block is size of (n/N) 2 so 
$$m =N^3 \left(\frac{n}{N}\right)^2 + N^3 \left(\frac{n}{N}\right)^2 + 2N^2 \left(\frac{n}{N}\right)^2$$
So computational intensity is $q = f / m = 2n^3 / ((2N + 2) \cdot n^2) = n / N = b$ for large N.

Why not increase b to a very large number?

- The tiled matrix multiply analysis assumes that three tiles/blocks fit into fast memory at once.
- If $M_{fast}$ is the size of fast memory then the previous analysis shows that the blocked algorithm has computational intensity:
	- $q \approx b \leq (\frac{M_{fast}}{3})^{1/2}$ 

# Basic Linear Algebra Subroutines (BLAS)
BLAS 1
- vector operations: dot product, saxpy, etc
- $m = 2 \cdot n, f=2 \cdot n, q = f/m$ around 1 or less
BLAS2
- matrix-vector operations: matrix vector multiply, etc
- $m=n^2, f=2 \cdot n^2, q \sim 2$ less overhead
- somewhat faster than BLAS1
BLAS3
- matrix-matrix operations, matrix matrix multiply, etc
- $m \leq 3n^2, f=\mathcal{O}(n^3)$ so $q = f / m$ can possibly be as large as n, so BLAS3 is potentially much faster than BLAS2

See LAPACK, ScaLAPACK

because of the higher q, BLAS3 operations can be optimized to get closer to machine peak.
