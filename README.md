# SIC  
A virtual machine for Single Instruction Computer.  
#Overview  
The SIC computer architecture has only one instruction: SBN A, B, C. SBN
stands for Subtract & Branch if Negative. This is an example of a oneinstruction computer, of which many are known. SIC is not a realistic computer architecture, in the sense that it would be worth implementing it in
hardware, but a theoretical one, in the sense that it is Turing-complete.  
For this assignment, you will write the following tools:  
1. A virtual machine for SIC, emulating the SBN instruction. This shall
be written in x86 assembly language.  
2. A second virtual machine for SIC, emulating the SBN instruction. This
shall be written in SIC assembly language, shall only use the instruction
SBN, and shall run on top of the virtual machine that you wrote in x86
assembly language. This program is essentially a bunch of numbers
that we too could run on our own virtual machine for SIC.  
You are given the code for computing Fibonacci numbers.
The finish-line for this assignment is to be able to run "a tower" consisting
of Fibonacci running on top of (2) running on top of (2) running on top of
(2), and so on, as many times as you like, running on top of (1). The ability
to run such a "tower" of virtual machines will be our demonstration that
your implementation of the virtual machine is correct.
