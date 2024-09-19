# ********************************************************************************************************
# * Assignment 1                                                                                         *
# * By Daan Geijsen & Nils Wagemaker                                                                     *
# ********************************************************************************************************
.data
welcome:            .asciz "\nAssignment 1\n====================\nName: Daan Geijsen\nNetID: dgeijsen\nName: Nils Wagemaker\nNetID: nwagemaker\n====================\n\n"
format_int:         .asciz "%ld"                # long decimal (64-bit integer)
prompt_base:        .asciz "Enter a non-negative base:\n"
prompt_exponent:    .asciz "Enter a non-negative exponent:\n"
output:             .asciz "> %ld\n"


.text
.global main


main:
    # prologue
    pushq           %rbp                        # push base pointer to stack
    movq            %rsp, %rbp                  # copy stack pointer to base pointer

    movq            $welcome, %rdi              # set $welcome as second parameter for printf
    movq            $0, %rax                    # no vector registers for printf
    call            printf

    subq            $16, %rsp                   # reserve

    movq            $prompt_base, %rdi          # set $prompt_base as second parameter for printf
    movq            $0, %rax                    # no vector registers for printf
    call            printf
    call            scan_int
    movq            %rax, -8(%rbp)              # set base

    movq            $prompt_exponent, %rdi      # set $prompt_exponent as second parameter for printf
    movq            $0, %rax                    # no vector registers for printf
    call            printf
    call            scan_int
    movq            %rax, -16(%rbp)             # set exponent
    
    movq            -8(%rbp), %rdi              # set base
    movq            -16(%rbp), %rsi             # set exponent
    call            pow

    movq            $output, %rdi               # set output
    movq            %rax, %rsi                 
    movq            $0, %rax
    call            printf

    # epilogue
    movq            %rbp, %rsp                  # clear local variables from stack
    popq            %rbp                        # restore base pointer location
    movq            $0, %rdi                    # set 0 as exit code
    call            exit
    ret


scan_int:
    # prologue
    pushq           %rbp                        # push base pointer to stack
    movq            %rsp, %rbp                  # copy stack pointer to base pointer

    subq            $16, %rsp                   # reserve stack space for variable
    leaq            -16(%rbp), %rsi             # set address of stack variable in %rsi
    movq            $format_int, %rdi           # set first argument of scanf
    movq            $0, %rax                    # no vector registers for scanf
    call            scanf
    movq            %rsi, %rax                  # set input as return value

    # epilogue
    movq            %rbp, %rsp                  # clear local variables from stack
    popq            %rbp                        # restore base pointer location
    ret


pow:
    # prologue
    pushq           %rsp                        # push base pointer to stack
    movq            %rsp, %rbp                  # copy stack pointer to base pointer

    movq            $1, %rax
    cmpq            $0, %rsi
    jle             .end   

    movq            %rdi, %rax                  # copy base to %rax to be multiplied

    .loop:                                      # loop as long as exponent > 0
    cmpq            $1, %rsi                    # compare exponent to 1
    jle             .end                        # jump to .end if loop is finished
    decq            %rsi                        # decrement exponent by one

    mulq            %rdi                        # multiply %rax by base
    
    jmp             .loop                       # jump to loop
    .end:

    # epilogue
    movq            %rbp, %rsp                  # copy base pointer to stack pointer
    popq            %rbp                        # pop base pointer from stack
    ret
