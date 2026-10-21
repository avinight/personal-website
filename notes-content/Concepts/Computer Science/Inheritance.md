Tags:
Links: [[148-CSC148]]

---
# Inheritance

Define a base class

Define a subclass for each specific type of employee

Inheritance terminology:
- base class, superclass, and parent class are synonyms
- derived class, subclass, and child class are synonyms

Base (abstract) classes
- Changing the body of an incomplete method so that it simply raises a `NotImplementedError`.
- A class which has at least one abstract method is an abstract class
- Add a comment to the class docstring stating that the class is abstract so that anyone writing client code is warned not to instantiate it.

It is possible for client code to ignore the warning and instantiate the class

Subclass inherit from the base class

Checking with method `isinstance` means that some object is an instance of the subclass and the base class.

We say that an object that is instantiated as a subclass, which has access to all methods of the base class, *inherits* all of the base class' methods.

Overrides is when the definition of a method is modified in another subclass.

We put an underscore at the end of an attribute to distinguish it from the built in function: `id_` vs. `id`

Four things 

1. Inherit an implemented method
2. Override an abstract method to implement it
3. Override an implemented method to replace it
4. Override an implemented method to extend it

Using inheritance to define a *shared public interface*
```Python
>>> employees = [
        SalariedEmployee(14, 'Fred Flintstone', 5200.0),
        HourlyEmployee(23, 'Barney Rubble', 1.25, 50.0),
        SalariedEmployee(99, 'Mr Slate', 120000.0)
    ]
for e in employees:
    # At this point, we don't know what kind of employee e is.
    # It doesn't matter, because they all share a common interface,
    # as defined by class Employee!
    # For example, they all have a pay method.
    e.pay(date(2018, 8, 31))
```

[[Polymorphism]]

[[Composition]]

The difference between composition and inheritance
- Composition: "has a" relationship
	- A house has a bed and a chair.
- Inheritance: "is a" relationship
	- A house is a building.
	Any change in a superclass affects all of its subclasses.

Prefer that a subclass not change the public interface of a superclass at all:
- not by changing the interface of any public methods (e.g., adding/removing parameters, or changing their types)
- not by adding new public methods or attributes to a subclass (of course, adding private attributes or methods is acceptable)