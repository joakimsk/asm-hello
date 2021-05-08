# ASM Tests
An attempt at learning some assembly

## Assemble
To assemble the .asm file into hello_world.o using the Mach-O 64bit object file notation format (used by MacOS Mojave)

nasm -f macho64 hello_world.asm

## Linking

Change version to sw_vers output, in my case 10.15.7
Check architecture using uname -a
Use -lSystem 
Use -macosx_version_min 10.15.7

On OS X 11 and higher, use
-L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib

ld -macosx_version_min 10.15.7 -o hello hello.o -lSystem -L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib

Use -s to strip the output, removing symbol table

## RIP-relative vs absolute addressing
Mac OS X may not allow absolute addressing. Can be handled in various ways.

Switch -no_pie to disable position independent code, or swap mov to lea

[link](https://gist.github.com/FiloSottile/7125822)
[link](https://stackoverflow.com/questions/47300844/mach-o-64-bit-format-does-not-support-32-bit-absolute-addresses-nasm-accessing)

## Structure of program

### data section
Used to declare initialized data, does not change at runtime.
Declared using section.data

### bss section
Used to declare variables.
Declared using section.bss

### text section
Used to keep the actual code, must begin with global _start or global _main depending on switch, tells kernel where to start
section.text
   global _start
_start:

## Registers
Read more about registers, depends on bitness 64, 32, 16, 8
https://www.cs.uaf.edu/2017/fall/cs301/lecture/09_11_registers.html

### Registers available on various architectures
Shamelessly copied from [link](https://www.cs.uaf.edu/2017/fall/cs301/lecture/09_11_registers.html)

| Name 	| Notes                                                                                           	| Type      	| 64-bit long 	| 32-bit int 	| 16-bit short 	| 8-bit char 	|
|------	|-------------------------------------------------------------------------------------------------	|-----------	|-------------	|------------	|--------------	|------------	|
| rax  	| Values are returned from functions in this register.                                            	| scratch   	| rax         	| eax        	| ax           	| ah and al  	|
| rcx  	| Typical scratch register.  Some instructions also use it as a counter.                          	| scratch   	| rcx         	| ecx        	| cx           	| ch and cl  	|
| rdx  	| Scratch register.                                                                               	| scratch   	| rdx         	| edx        	| dx           	| dh and dl  	|
| rbx  	| Preserved register: don't use it without saving it!                                             	| preserved 	| rbx         	| ebx        	| bx           	| bh and bl  	|
| rsp  	| The stack pointer.  Points to the top of the stack                                            	| preserved 	| rsp         	| esp        	| sp           	| spl        	|
| rbp  	| Preserved register.  Sometimes used to store the old value of the stack pointer, or the "base". 	| preserved 	| rbp         	| ebp        	| bp           	| bpl        	|
| rsi  	| Scratch register.  Also used to pass function argument #2 in 64-bit Linux                       	| scratch   	| rsi         	| esi        	| si           	| sil        	|
| rdi  	| Scratch register.  Function argument #1 in 64-bit Linux                                         	| scratch   	| rdi         	| edi        	| di           	| dil        	|
| r8   	| Scratch register.  These were added in 64-bit mode, so they have numbers, not names.            	| scratch   	| r8          	| r8d        	| r8w          	| r8b        	|
| r9   	| Scratch register.                                                                               	| scratch   	| r9          	| r9d        	| r9w          	| r9b        	|
| r10  	| Scratch register.                                                                               	| scratch   	| r10         	| r10d       	| r10w         	| r10b       	|
| r11  	| Scratch register.                                                                               	| scratch   	| r11         	| r11d       	| r11w         	| r11b       	|
| r12  	| Preserved register.  You can use it, but you need to save and restore it.                       	| scratch   	| r12         	| r12d       	| r12w         	| r12b       	|
| r13  	| Preserved register.                                                                             	| scratch   	| r13         	| r13d       	| r13w         	| r13b       	|
| r14  	| Preserved register.                                                                             	| scratch   	| r14         	| r14d       	| r14w         	| r14b       	|
| r15  	| Preserved register.                                                                             	| scratch   	| r15         	| r15d       	| r15w         	| r15b       	|


## Syscall
System calls can be called from code, depends on OS/architecture.
See on OS X: /Library/Developer/CommandLineTools/SDKs/MacOSX11.1.sdk/usr/include/sys/syscall.h

[linux system calls](https://www.tutorialspoint.com/assembly_programming/assembly_system_calls.htm)
[os x system calls howto 32 vs 64 bit](https://filippo.io/making-system-calls-from-assembly-in-mac-os-x/)
[os x system calls](https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master)

For 64 bit, put system call in rax register, you need to add 0x20000000 to the syscall int

Used syscalls:
1	AUE_EXIT	ALL	{ void exit(int rval); }
4	AUE_NULL	ALL	{ user_ssize_t write(int fd, user_addr_t cbuf, user_size_t nbyte); } 

### On 64 bit OS X
We put our syscall function in rdx


We put our arguments in:
- rdi (first argument)
- rsi (second argument)
- rdx (third argument)
- r10, r8, r9 (and so forth)

## Check retval of exit
./exit; echo $?

Should return 0 for a correct exit