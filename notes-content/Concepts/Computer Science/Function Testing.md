Tags:
Links: [[148-CSC148]], [[Function Design Recipe]], <a href=https://hypothesis.readthedocs.io/en/latest/index.html>Hypothesis Testing </a>

---
# Function Testing

Doctesting
```Python
if __name__ == '__main__':
    import doctest     # import the doctest library
    doctest.testmod()  # run the tests
```

Testing around properties of inputs
- Integers
	- 0, 1, positive, negative, "small", "large"
- Strings
	- empty, length 1, alphanumeric characters only, special characters like punctuation marks
- Lists
	- empty, length 1, no duplicates, duplicates, sorted, unsorted


How to choose relevant properties
- the size of an object (could be a list, string, etc.): 
	- 0, 1, larger, even, odd
- the position of a value in an ordered sequence (such as a list or string):
	- beginning, ending, elsewhere
- the relative position of two values in an ordered sequence: 
	- adjacent, separated
- the presence of duplicates: 
	- yes, no
- ordering: 
	- unsorted, non-decreasing, non-increasing
- the value of an integer: 
	- 0, 1, positive, negative, “small”, “large”, even, odd
- the value of a string: 
	- alphanumeric characters only, special characters like punctuation marks
- the location of whitespace in a string: 
	- beginning, ending, elsewhere, multiple occurrences, multiple adjacent whitespace characters, different types of whitespace characters
- and more! Depending on the parameters of a function, there could be many other properties.
