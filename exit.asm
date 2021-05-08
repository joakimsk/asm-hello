global _main

section .text

_main:
    mov rax, 0x02000001     ; add syscall exit()
    xor rdi, rdi			; set retval = 0
    syscall					; call exit()