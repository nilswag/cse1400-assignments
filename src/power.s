# ***************************************************************************
# * Program: Assignment 1                                                   *
# * Description: Calculates the powers of non-negative bases and exponents. *
# ***************************************************************************

.text
.global main

main:
    # prologue
    pushq           %rbp                            # push the base pointer to the stack
    movq            %rsp, %rbp                      # copy the stack pointer to the base pointer
    
    # epilogue
    movq            %rbp, %rsp                      # copy the base pointer to the stack pointer
    popq            %rbp                            # pop the base pointer from the stack
    
    movq            $0, %rdi                        # set 0 as exit code
    call            exit
