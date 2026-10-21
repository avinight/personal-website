Tags:

---

why is it a spurious tuple? <n, f, l, c, g> 

If there were no FDs at all, is it possible that the decomposition is lossless?  
Solution: This particular decomposition is lossy if there are no functional dependencies. And in fact this holds  
for any non-trivial decomposition, that is, any decomposition into 2 or more relations, none of which includes all  
the attributes of the original relation.  

Important: In practise, one never invents FDs! They are facts about the domain that either hold or don’t hold. So  
this question is completely unrealistic, but if you can solve it, you really understand the Chase Test.
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---