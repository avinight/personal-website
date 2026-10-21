---
tags:
  - math
---
rank(M) = dim(range(T_M)) = dim(col(M)) where T_M is the transformation induced by M. 

A basis for col(M) consists of a maximal linearly independent subset of the columns of M.

To find the subset, row reduce M and look at the columns of M that correspond to the pivot columns of rref(M)

The number of elements in a basis for col(M) is the number of pivots in rref(M)