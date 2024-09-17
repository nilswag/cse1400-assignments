.section .data               # Section for initialized data
hello: 
    .string "Hello, World!\n"  # Null-terminated string

.section .text               # Section for code
.globl _start                # Entry point for the linker
_start:
    # Write system call
    movq $1, %rax            # System call number for sys_write (1)
    movq $1, %rdi            # File descriptor (stdout)
    leaq hello(%rip), %rsi   # Pointer to the "Hello, World!" string
    movq $14, %rdx           # Length of the string
    syscall                  # Make the system call

    # Exit system call
    movq $60, %rax           # System call number for sys_exit (60)
    xor %rdi, %rdi           # Exit status (0)
    syscall                  # Make the system call
