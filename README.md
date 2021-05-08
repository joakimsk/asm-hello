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

### Scratch registers on 64 and 32 bit
rcx, ecx
rdx, edx
rsi, esi
rdi, edi
r8, r8d
(..)
r11, r11d

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

rdi (first argument)

rsi (second argument)

rdx (third argument)

r10, r8, r9

## Check retval of exit
./exit; echo $?

Should return 0 for a correct exit