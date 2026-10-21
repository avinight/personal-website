Tags:

---
Allocating memory to data -> Garbage collection

Unix Principles
- Do one basic thing well
- Separate Programs
- mv - move
- cp - copy

Unix command line 

**_Demo of some tools_**
- cd : change directory
- ls : list subdirectories (1 OA = list)
- “-“ : Optional arguments
- wc : word count (1 arg = file name) return (line count, word count, char count)
- cat : concatenate (1 arg = file name) return file in text
- sort : take in text and sort the lines based on some order
- man : manual 

dattum : many data

terminal/command line/shell = controller
$ - shell prompt

Type in text -> shell executes -> execute program
Equivalent to double-clicking program on computer.

shells have built-in commands = keywords
Standard output: the (default) place where programs print text
Standard input: the (default) place where programs read in text (user input)
wc does the word count for its “standard input” : enter on command line

**Redirect**

“<“ : input redirection
“>” : output redirection

**Piping**

- “|” redirecting standard output into standard input of another program
Sample usage: 
- `./prog output | input`

**An introduction to filesystem**

An **inode** is a data structure that contains information about a file 

- Metadata (e.g. owner, creation time)
- Where the file contents are stored on disk

chmod : changes permissions

**Creating programs**

**_Main command to compile C programs_**

gcc : compiler
-Wall : all warnings
-g : insert debugging symbols
-std=gnu99 what is the version of C 
-o : output name

Some tools 
cut - remove sections from each line of files
grep - print lines that match patterns
sort - sort lines of text files
uniq - filters adjacent lines from stdin

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---