---
tags:
  - course/csc343
  - computer-science
---
Tags:

---

1. Write a query to find the average grade, minimum grade, and maximum grade for each offering.

```sql
SELECT o.oID, AVG(g.grade), MIN(g.grade), MAX(g.grade)
FROM Offering o 
JOIN Took t ON o.oID = t.oID
GROUP BY o.oID;
```

2. Which query is legal 
	- all except c
3. Write a query to find the sid and minimum grade of each student with an average over 80.

```sql
SELECT sid, MIN(g.grade)
FROM (Student NATURAL JOIN Took) g
GROUP BY sid
HAVING AVG(g.grade) > 80;
```

4. Find the sid, surname, and average grade of each student, but report the results only for those students who have taken at least 10 courses.

```sql
SELECT sid, surname, AVG(g.grade)
FROM (Student NATURAL JOIN Took) g
GROUP BY sid, surname
HAVING COUNT(g.oID) >= 10;
```

5. For each student who has passed at least 10 courses, report their sid and average grade on the courses that they passed.

```sql
SELECT sid, AVG(g.grade)
FROM (Student NATURAL JOIN Took) g
WHERE g.grade >= 50
GROUP BY sid
HAVING COUNT(g.oID) >= 10;
```

6. For each student who has passed at least 10 courses, report their sid and average grade on all of their courses


<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---