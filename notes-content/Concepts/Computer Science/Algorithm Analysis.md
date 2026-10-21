Tags:
Links:

---
# Algorithm Analysis

```Python

0. def algo(n: int) -> int:
1.	r = 0
2.	for i in range(10):	# Loop 1
3.		for j in range(n * n): # Loop 2
4.			r = r + j
5.	for i in range(n // 2): # Loop 3
6.		for j in range(i * i): # Loop 4
7.			r = r - j
8.	return r
```

WANT: $RT(n) \in \Theta(\_)$

$RT(n)$ denotes the runtime functino for algo. for each input n, RT(n) = #"steps" executed by algo on n.

There is no absolute definition of "one step". What matters is that code that takes constant time is assigned constant "cost".

Analysis of example -> work inside out

Loop 2:
- loop body (line 4) takes time: 1
- # iterations? n^2

[for j in range (n * n) _ for j = 0, 1, 2, ..., n*n - 1]
- total time( lines 3-4): 1 + ... + 1 n^2 times = n^2

Loop 1:
- body(lines 3-4): n^2
- # iterations: 10
- total (lines 2-4) 10n^2

When the runtime of the body changes, do the actual sum.

General formula: i < n // 2, i^2
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---