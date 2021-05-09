BITS 64
DEFAULT REL ; RIP-relative addressing by default

SYS_EXIT  equ 0x02000001
SYS_READ  equ 0x02000003
SYS_WRITE equ 0x02000004
STDIN     equ 0
STDOUT    equ 1

section .data
    msg1:    db        "Text", 0x0A, 0x0D
    len1 equ $- msg1

    msg2: db "The sum is:", 0x0A, 0x0D
    len2 equ $- msg2

section .bss
    res resb 2

section .text
    global _main

_main:
    mov rsi, '4'
    sub rsi, '0'

    mov rdi, '5'
    sub rdi, '0'

    call _sum
    mov [res], rax

_output:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    lea rsi, msg2
    mov rdx, len2
    syscall

    mov rax, SYS_WRITE
    mov rdi, STDOUT
    lea rsi, res
    mov rdx, 1
    syscall
_exit:
    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall
_sum:
    mov rax, rsi
    add rax, rdi
    add rax, '0'
    ret