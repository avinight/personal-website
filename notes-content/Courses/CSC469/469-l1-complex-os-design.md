---
tags:
  - course/csc469
  - computer-science
---

# l1 Complex OS Design

System: 
- A complex unity formed of many often diverse parts subject to a common plan or serving a common purpose
- The whole is more than the sum of the parts
- Stability - Complex systems resist change

Why are software systems tough and interesting?

Think-Pair-Share


### Problems in Complex Systems
Emergent properties
Propagation of effects
Incommensurate Scaling
Trade offs

# Salzer Paper


Possible problems
- Software bugs
- Hardware failure
- Network Error
- Power failure

*End-to-end argument or principle*: Don’t implement some function in low-level software layers if higher-level software must help get that function right.
In other words, functions that depend on endpoints should be implemented at the endpoints, not at any intermediate stage between endpoints as the risk of potential failures increases. Some examples are E2E encryption

- Endpoint checks are required no matter how reliable the intermediate steps are.
	- Repeating the checks at the lower layers just adds overhead

Considerations
- Should the intermediate levels provide no reliability then?
- "Clearly, some effort at the lower levels to improve network reliability can have a significant effect on application performance. But the key idea here is that the lower levels need not provide 'perfect reliability’.”
- “Thus the amount of effort to put into reliability measures within the data communication system is seen to be an engineering trade-off based on performance, rather than a requirement for correctness.”
- Use performance to justify placement
	- Performing a function at a lower level may be more efficient
	- However, it could also indirectly cost more

Advice on system design
- Key principle is separating interface from implementation
	- Clients rely on the interface; implementation hides what can change
- Additional takeaways
	- Assumptions at lower layer can improve performance, but create coupling and reduce flexibility
	- Avoid generality unless it can be implemented efficiently 
		- Premature generalization is usually wrong
	- Separate the common case from the worst case
		- Optimize the normal path
		- Handle failures with a different strategy
