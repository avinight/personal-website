Tags:
Links:

---
# Classes
```toc
```
Classes in Java are similar to those in Python: they consist of attributes and methods, both private and public. We can inherit from other classes, override methods, and define constructors.

## Variables in Java

Unlike Python, we have to declare variables before using them in Java. There are two kinds of variables we can declare for classes, outside of any method:

- Instance variables: Every instance of the class will contain its own instance of each of these variables. They come into existence when the instance is constructed (using the `new` keyword).
- Class (static) variables: All instances of a class share a _single_ instance of each class variable. Useful for when all classes accumulate a value together.

## Visibility

Attributes and methods can be either **public** or **private**. In Java we use the `public` or `private` keywords to make this distinction: private variables _cannot_ be accessed from outside of a class. We can also use the `protected` keyword, making the attribute or method accessible to the entire package and a class' subclasses, but not to anything else.

## Constructors

In Java, we can define as many constructors as we want so long as the method signatures are different: either taking a different number of arguments, having different argument types, or a combination of these.

## Overloading methods

When we define multiple constructors, we are **overloading** the constructor.

```Java
public int my_method(int something, int something_else){
    return something + something_else;
}

public int my_method(int something){
    return my_method(something, 1);
}
```

## Overriding methods

## Comparable

## Comparator

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---