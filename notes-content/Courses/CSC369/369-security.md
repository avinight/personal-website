---
tags:
  - course/csc369
  - computer-science
---
Tags:

---
Bugs
• What is a "flaw" in the operating system?
	• A bug is unintended behavior
• May be caused by
	- Bad compiler, libraries, user code, input, design
	- Hardware error
• This definition covers all possible security holes
	• Any bug is a potential security hole
	• A bug does not necessarily lead to a crash or visible failure
	• A bug that can be exploited is called a vulnerability

Exploits
• Taking advantage of vulnerability to perform actions normally restricted
	• Contrary to typical policy
		• E.g., unauthorized access to files
	• Not limited to security breaches
		• E.g., causing system unavailability through crashes or slowdown
• Local exploit
	• Requires initial access to the system
		• Can be achieved through physical access or network login
• Remote exploit
	• Targets network services
		• Can be executed without prior access to the system
 
Stack & Buffer Overflow attacks
 Most common means of gaining unauthorized access to a system
• Root cause: unsanitized user input
	• No validation or filtering of user-provided data, e.g., through stdin
	• Attackers can inject malicious input to corrupt memory
• How it works:
1. Overflow the buffer
	• Input exceeds the buffer’s allocated space
2. Overwrite the return address
	• The excess data corrupts the stack, overwriting the function’s return address
3. Execute malicious code
	• Attacker places exploit code (shellcode) in the overflowed buffer.
	• Return address points to this code, hijacking program execution.

Exploiting code bugs
• We saw an example of code injection with a buffer overflow
• What are some defenses?
	• Programmer
		• Input validation, bound checking, safe functions (e.g., strncpy over strcpy)
	• Compiler
		• Stack canary
			• A special value between the buffer and the return address
			• If the canary is changed upon return, crash the program
	• Operating system
		• Non-executable stack
		• Address space layout randomization

Return to libc attacks
• Attacker does not have to inject new code
• Return-to-libc attacks
	• Attacker repurposes existing code for malicious purposes
	• No shellcode needed!
	• Overwrite return address with an address inside the C standard library (libc)
	• libc code is not on the stack, so executable stack is not required
• Review: C calling convention
1. Push arguments
2. Push return address
3. Jump to function

Address space layout randomization
• A security feature that randomizes memory addresses
• E.g., stack, heap, code, libraries, etc.
• This makes exploits much more difficult
	• Attacker no longer knows the exact addresses of functions and variables
	• Buffer overflow
		• Return address changes on each run
	• Return-to-libc
		• libc addresses are randomized

Format string bugs
• C library formatted I/O strings can allow almost arbitrary inspection and modification of program if misused
	• First known exploit in 1999
	• A popular FTP server was exploited, allowing attacker to gain root access
• Example
	• printf(inputstr) where inputstr is supplied by user
	• inputstr can contain format characters (like %x)
	• printf assumes extra arguments have been pushed on stack
		• If not, it would dumps stack contents to standard output!
	• Additionally, %n format allows write to a memory location

• A vulnerability is a weakness in a system, software, or protocol
• An exploit can compromise security by taking advantage of a
vulnerability to execute malicious actions
• Stack smashing attack attempts to overwrite the return address of a
function call, to execute arbitrary code
	• E.g., buffer overflow attack, return-to-libc attack, format string attack, etc.
• Defenses (all of these are enabled by default nowadays)
	• Stack canary
	• Make stack non-executable
	• Address space layout randomization
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
https://en.wikipedia.org/wiki/Position-independent_code