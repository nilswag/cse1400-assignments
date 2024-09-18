# ********************************************************************************************************
# * Assignment 1                                                                                         *
# * By Daan Geijsen & Nils Wagemaker                                                                     *
# ********************************************************************************************************

.text
welcome:                .asciz "\nAssignment 1\nName: Daan Geijsen\nNetID: dgeijsen\nName: Nils Wagemaker\nNetID: nwagemaker\n\n"

.global main

main:
    # prologue
    pushq               %rbp                                    # push base pointer to stack
    movq                %rsp, %rbp                              # copy stack pointer to base pointer

    movq                $0, %rax
    movq                $welcome, %rdi
    call                printf

    # epilogue
    movq                %rbp, %rsp                              # copy base pointer to stack pointer
    popq                %rbp                                    # pop base pointer from stack

    movq                $0, %rdi                                # set 0 as exit code
    call                exit


# ********************************************************************************************************
# * Subroutine: pow                                                                                      *
# * Description: calculates base to the power of non-negative exponents                                  *
# * Parameters: %rdi = base, %rsi = exponent                                                             *
# * Returns: base to the power of the exponent                                                           *
# ********************************************************************************************************
pow:
    # prologue
    pushq               %rsp                                    # push base pointer to stack
    movq                %rsp, %rbp                              # copy stack pointer to base pointer

    

    # epilogue
    movq                %rbp, %rsp                              # copy base pointer to stack pointer
    popq                %rbp                                    # pop base pointer from stack
