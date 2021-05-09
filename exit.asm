BITS 64
DEFAULT REL ; RIP-relative addressing by default

section .text
    global _main
_main:
    mov rax, 0x02000001     ; add syscall exit()
    xor rdi, rdi            ; set retval = 0
    syscall                 ; call exit()