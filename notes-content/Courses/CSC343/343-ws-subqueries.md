---
tags:
  - course/csc343
  - computer-science
---
Tags:

---

1.
```sql
SELECT sid, dept || cnum as course, grade
FROM Took,
	(SELECT *
	FROM Offering
	WHERE instructor = ’Horton’) Hoffering
WHERE Took.oid = Hoffering.oid;
```

Returns all students that have taken courses offered by Diane Horton
Reports student number, course taken, grade.

2.
```sql
SELECT sid, surname
FROM Student
WHERE cgpa >
	(SELECT cgpa
	FROM Student
	WHERE sid = 99999);
```


<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---