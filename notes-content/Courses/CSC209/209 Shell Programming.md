---
tags:
  - course/csc209
  - computer-science
---
Tags:

---

https://www.teach.cs.toronto.edu/~ajr/209/video/shell01/transcript.html
---
`*` is used in command-line substitutions to match with files contained in the directory
`echo` prints the values of its arguments
`$` next to an assigned value refers to that assigned value (interpolation of the value)
`expr` performs command-line arithmetic
back quotes are another form of substitution which takes command line programs' output and assigns them to a value. These differ from single quotes, which suppress the interpretation by the shell of the symbol it delimits.
`cat` is a standard Unix utility that concatenates and displays files. The name `cat` is short for "concatenate".
`diff` command in Unix/Linux is used to compare the contents of two files line by line. It's a very useful tool for viewing the differences between files, especially for tasks like debugging or identifying changes between file versions.

![[Diff Command.png]]

![[Shell Command Example.png]]

![[Shell Programming Study Note.png]]

https://www.teach.cs.toronto.edu/~ajr/209/video/shell02/transcript.html
---
`0` is the success status. Anything non-zero indicates failure
`$?` exit status
`test`
`sh`
#### Control Constructs
---
```sh
if grep $name students
then
	echo end of list
else
	echo No students named $name
fi
```

```ad-note
title: test comparison operators

-lt: less than
-gt: greater than
-eq: equal to
-ne: not equal to
-le: less than or equal to
-ge: greater than or equal to

= and != are string comparison operators
```
```ad-note
title: test file testing operators

-f file: file exists
-d file: file exists and is a directory
-s file: file exists and is a directory and is of non-zero size
```

```sh
while grep Q file
do
	(echo 1d; echo w) | ed - file
done
```
`1d` means delete first line
`w` means write to file
`ed -` suppresses the extra stuff like prompts

`/dev/null` is the garbage file, we redirect here if we want to discard

`&&` and `||` denote and and or

```sh
if test $x -gt 3 && test $x -lt 10
```
exit status of compound statement is right command if left command succeeds
exit status of compound statement is left command if left command fails. Right command is not executed

```sh
if foo1
then 
	:
elif foo2
then
	bar2
else
	bar3
fi
```


DONT DO THIS,  this is what `if` does, if the command succeeds or fails
```sh
foo
if test $? -eq 0
then
	something
fi
```
DO THIS INSTEAD
```sh
if foo
then 
	something
fi
```


![[Shell If Statement Example.png]]

![[Shell Programming Follow Up.png]]

![[Shell Command Redirect.png]]

https://www.teach.cs.toronto.edu/~ajr/209/video/shell03/transcript.html
---
in C: `"sh"` <-> `sh` are different
in sh: `"sh"` <-> `sh` are the same, everything is a string

```ad-note
title: Double quotes suppress everything except

dollar sign
backquote
backslash
closing double quote

```
`seq` outputs a range of numbers based on its arguments (like range in Python)
https://linux.die.net/man/1/seq

```sh
for i
do
	case $i in
		hello)
			echo Hi! Nice to see you!
			;;
		goodbye)
			echo 'Thanks for visiting!'
			;;
		*)
			echo well, $i to you too!
			;;
	esac
done
```
![[Shell Scripting Arguments.png]]

![[Shell Programming Follow Up Question.png]]

![[Shell Programming Follow Up (2).png]]

https://www.teach.cs.toronto.edu/~ajr/209/video/shell04/transcript.html
---
I/O redirection
```sh
foo <file1 >file2
bar >>file2  #`>>` sends output to append to file instead of overwrite
```


`wc -l` 

`<<` takes input right from shell, followed by token which when found later alone on a line terminates the input. (here is text or here text)

quoting the token suppresses the meaning of symbols in the here-is text and are taken literally.
like `<<\EOF`

`2>file` redirect out from stderr
specify which file descriptor to redirect
`cmd >file1 2>file2` means to redirect out to file 1 and stderr to file 2
`foo >&2` means to redirect into stderr

`$#` means number of command line args
`$**` expands to all arguments

`$@` preserves quotation, `$*` doesn't preserve quotation, but both are used for all arguments.

`"$@"` doesn't suppress quotes in CLAs
`$@` functions exactly like `$*`
`shift` command moves command line args down one place

`${x}` means the same thing as `$x` but you can make stuff part of the same word
![[Shell Scripting Exercise.png]]

![[Shell Programming Follow Up (3).png]]

![[Shell Arguments Question.png]]

### Shell Worksheet
---
7 and 8
To find the differences between two files, you can use the `diff` command. Here's how you can compare the two files `chapter1` and `chapter-one`:

```sh
diff /u/csc209h/winter/pub/shell-prog/chapter1 /u/csc209h/winter/pub/shell-prog/chapter-one
```

This command will output the differences between the two files. The file with the mistake will have lines that are not present in the file with the correction.

To find the file that is different among files named 0 through 9, you can use a loop that compares each file to the first one. If `diff` outputs anything, that means the file is different. Here's a simple script that does this:

```sh
for i in {1..9}; do
    if diff /u/csc209h/winter/pub/shell-prog/0 /u/csc209h/winter/pub/shell-prog/$i > /dev/null; then
        :
    else
        echo "File $i is different"
    fi
done
```

This script compares each file to the file `0`. If any differences are found, it prints a message indicating which file is different.

If you had 100 files, you could modify the loop to iterate from 1 to 99 instead of 1 to 9. The rest of the script would remain the same.

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- [https://youtu.be/iK6AVaBJVKA](https://youtu.be/iK6AVaBJVKA "Share link")
- [https://youtu.be/iZuXiEYv_D4](https://youtu.be/iZuXiEYv_D4)
- [https://youtu.be/Rj7fiH8uPJU](https://youtu.be/Rj7fiH8uPJU "Share link")
- 