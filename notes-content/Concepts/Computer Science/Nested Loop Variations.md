Tags:
Links: [[165-CSC165]]

---
# Nested Loop Variations

1.  (i)  First, determine an expression for the exact cost (# of steps) of the inner loop for a fixed iteration of the outer loop. This may or may be the same for each iteration of the outer loop.
    
2.  (ii)  Determine the total cost of the outer loop by adding up the costs of the inner loop from (i). If the cost of the inner loop is the same for each outer loop iteration, you can simply multiply this cost by the total number of iterations of the outer loop. Otherwise, you’ll need to set up and evaluate a summation (Σ).
    
3.  (iii)  Repeat steps (i) and (ii) if there is more than one level of nesting, starting from the innermost loop and working your way outwards. Your final result should depend only on the function input, not any loop variables.