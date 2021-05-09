global _main

section .text
_main:                      ; tells linker entry point
    mov rax, 0x02000004     ; 64 bit register syscall to  ssize_t write(int fd, const void *buf, size_t nbytes);
    mov rdi, 1              ; rdi scratch register, set file descriptor = stdout (1)
    mov rsi, msg            ; rsi scratch register, put pointer to message inside it
    mov rdx, 13             ; rdx scratch register, put 13 inside it, number of bytes
    syscall

    mov rax, 0x02000001     ; syscall.exit()
    xor rdi, rdi
    syscall

section .data
msg:    db        "Hello, World", 10