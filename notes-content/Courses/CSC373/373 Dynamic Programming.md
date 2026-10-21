Tags:

---

• High-level steps in designing a DP algorithm
➢ Focus on a single decision in optimal solution
o Typically, the first/last decision
➢ For each possible way of making that decision...
o Optimal substructure - Write the optimal solution of the problem
in terms of the optimal solutions to subproblems
➢ Generalize the problem...
o ...by looking at the type of subproblems needed
o E.g., in the edit distance problem, we realize that we need to solve
the problem for prefixes x 1 , ... , xi and (y 1 , ... , y j ) for all (i, j)
➢ Write the Bellman equation, cover your base cases
➢ Think about optimizing the running time/space using tricks
o Often easier in the bottom-up implementation

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---