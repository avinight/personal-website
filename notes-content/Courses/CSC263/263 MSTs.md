Tags:

---
CLRS 23

![[23.1 5 MST Proof.png]]
Suppose for every MST of G, T includes e. Take C = (S, V - S) to be any cut of G. Then e is never light since either it is max (and in a cycle) or it never crosses C. Since this is true for all cuts, e is not safe. Contradiction.

![[MS Ts Cut Analysis.png]]
Let G = (V, E) be a graph with this property. We wish to use Theorem 23.1. So let A be a subset of edges included in some MST, T for G. Then define S subset of V such that (S, V - S) is a cut of G that respects A. Let (u, v) be a light edge crossing (S, V - S). By the property, this edge is unique. By Theorem 23.1, this edge is also safe for A. Applying Generic-MST on G, with weight function w yields the desired result. 

Counterexample. Consider V = (a, b, c), E = {(a, b), (a, c), (b, c)} with G = (V, E) undirected. Take w(a, b) = 1, w(a, c) = 1, w(b, c) = 2 to be the weight function.

![[23.1 7 MST Counterexample.png]]
Suppose G is a graph with any subset of edges having at least one cycle. Then remove the maximum edge in the cycle. This new subset connects all vertices and all its edges have positive weights. The weight of this new subset is less than the minimum total weight of the old subset (tree). Contradiction. 

Now the same conclusion doesn't follow if all edge weights are non-positive by considering the graph G = (V = {a, b, c}, E = {(a, b), (a, c), (b, c)}) with w = zero map.

![[Minimum Spanning Tree Proof.png]]
Consider a cut of a light edge e in T. If e is not unique then there are other trees T' containing the other light edges with the same weight. If e is unique then all trees contain the same e. WLOG, this means that the sorted list of edge weights L applies to every other T'.

![[Minimum Spanning Tree Properties.png]]
T' is connected so it spans G' and is a tree. T' also has minimum total weight since T does. T' is acyclic since T is.



<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---