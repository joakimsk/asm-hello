BITS 64
DEFAULT REL ; RIP-relative addressing by default

SYS_EXIT  equ 0x02000001
SYS_READ  equ 0x02000003
SYS_WRITE equ 0x02000004
STDIN     equ 0
STDOUT    equ 1

section .data
    msg1:    db        "Program start", 0x0A, 0x0D, "You are welcome. Returning value", 0x0A, 0x0D
    len1 equ $- msg1

    msg2:    db        "Enter number 1:"
    len2 equ $- msg2

    msg3:    db        "Enter number 2:"
    len3 equ $- msg3

section .bss
    num1 resb 2
    num2 resb 2
    res resb 1

section .text
    global _main

_main:        ; tells linker entry point
    ;mov rax, SYS_WRITE
    ;mov rdi, STDOUT
    ;mov rsi, msg1
    ;mov rdx, len1
    ;syscall

    ;mov rax, SYS_WRITE
    ;mov rdi, STDOUT
    ;mov rsi, msg2
    ;mov rdx, len2
    ;syscall

    ;mov rax, SYS_READ
    ;mov rdi, STDIN
    ;mov rsi, num1
    ;mov rdx, 2
    ;syscall

    ;mov rax, SYS_WRITE
    ;mov rdi, STDOUT
    ;mov rsi, msg3
    ;mov rdx, len3
    ;syscall

    ;mov rax, SYS_READ
    ;mov rdi, STDIN
    ;mov rsi, num2
    ;mov rdx, 2
    ;syscall

    ;mov rax, SYS_WRITE
    ;mov rdi, STDOUT
    ;mov rsi, num1
    ;mov rdx, 2
    ;syscall

    mov rsi, 1
    mov rdi, 5
    add rsi, rdi
    ;lea rsi, [num1]
    ;sub rsi, '0'
    ;lea rdi, [num2]
    ;sub rdi, '0'
    ;add rsi, rdi
    ;add rsi, '0'

    ;mov rax, SYS_WRITE
    ;mov rdi, STDOUT
    ;mov rsi, res
    ;mov rdx, 1
    ;syscall

    mov rax, SYS_EXIT
    xor rdi, rsi
    syscall