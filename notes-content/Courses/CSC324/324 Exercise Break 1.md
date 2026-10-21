---
tags:
  - course/csc324
  - computer-science
---
Tags:

---


1.1
```racket
(define (length lst)
	(if (empty? lst) 
		0
		(+ 1 length (rest lst)))))
```

car = contents of address part of register (first element)
cdr = contents of decrement part of register (rest of elements)

1.2
```racket
(define (member x lst)
	(cond [(empty? lst) 0]
		  [(equal? x (first lst))]
		  [else (member x (rest lst))])))
```

1.3
```racket
(define (count-duplicates lst)
	(cond [(empty? lst) 0]
		  [(member (first lst) (rest lst)) (+ 1 (count-duplicates (rest lst)))]
		  [else (count-duplicates (rest lst))]))
```

1.4
```racket
(define (remove-duplicates lst)
	(cond [(empty? lst) lst]
		  [(member (first lst) (rest lst)) (rest lst)]
		  [else (remove-duplicates (rest lst))]))
```

1.5
```racket
(define (intersection lst1 lst2)
	(cond [(empty? lst) lst]
		  [(equal? (first lst1) (first lst2)) (cons (first lst1) (intersection (rest lst1) (rest lst2)))]))

(define (union lst1 lst2)
	(cond [(empty? lst) lst]
		  [(cons (first lst1) (cons (first lst2) (union (rest lst1) (rest lst2))))]))
```

1.6
```racket
(define (largest-item lst)
	cond [(empty? lst) lst]
	     [(first lst) ()])
```

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---