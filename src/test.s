.text
.global main

format_str:             .asciz "%ld"

main:
    pushq               %rbp
    movq                %rsp, %rbp
    
    subq                $16, %rsp              # Allocate 16 bytes to ensure stack alignment
    
    leaq                -8(%rbp), %rsi         # Address to store the input (aligned)
    leaq                format_str(%rip), %rdi # Load address of format string
    
    movq                $0, %rax               # No floating-point arguments
    call                scanf                  # Call scanf

    movq                %rbp, %rsp
    popq                %rbp
    movq                $0, %rdi
    call                exit
    ret
