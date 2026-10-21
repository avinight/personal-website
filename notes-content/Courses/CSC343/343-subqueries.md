Tags:

---

Subqueries in a FROM clause
- In place of a relation name in the FROM clause, we can use a subquery.
- The subquery must be parenthesized.
- Must name the result, so you can refer to it in the outer query.

Subquery as a value in a WHERE clause
- If a subquery is guaranteed to produce exactly one tuple, then the subquery can be used as a value.
- Simplest situation: that one tuple has only one component.

When a subquery can return multiple values, we can make comparisons using a quantifier.

The ANY operator

The ALL operator

The IN operator

The EXISTS operator

Scope
- Scope
- If a name might refer to more than one thing, use the most closely nested one.
- If a subquery refers only to names defined inside it, it can be evaluated once and used repeatedly in the outer query.
- If it refers to any name defined outside of itself, it must be evaluated once for each tuple in the outer query. These are called *correlated subqueries*



<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---