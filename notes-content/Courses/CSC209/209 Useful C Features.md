Tags:

---
```ad-note
title: Definition

`typedef` allows you to create aliases for types and is evaluated by the compiler

> typedef is easier to read in structs
```
```ad-note
title: Definition

`macros` lets you define keywords that are replaced by specified strings when your programs is processed before being compiled

```
`#define` is a macro that is preprocessed before compilation. Macros aren't C so you dont need a semicolon or equals sign 

Gotchas
- no space between macro name and "(", leaving a space makes the processor think the macro has no params and replaces the macro name with the rest of the line. `#define WITH_TAX (x) ((x) * 1.08)`
- Inside the macro definition, the macro name should be placed in parentheses`#define WITH_TAX (x) (x * 1.08)`. If it wasn't then something like `WITH_TAX(purchase + purchase2)` would evaluate to `purchase + purchase2 * 1.08`. Order of operations is not clear.

Exercise: Omit outer parentheses in macro definition

This is correct: `#define WITH_TAX(x) ((x) * 1.08)

`size_t` - malloc arguments and returned by sizeof

```ad-note
title: Definition

`ifndef` or "If not defined", checks whether a particular macro or symbol has not been defined previously in the code. If the specified macro or symbol is not defined, the code within the `#ifndef` block will be included in the compilation.

```C
#ifndef MACRO_NAME
// Code to be compiled if MACRO_NAME is not defined
#endif
```
In essence, it is so we don't redefine things, over and over. We only want to include the header's declarations once.



<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---