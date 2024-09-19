# ********************************************************************************************************
# * Assignment 1                                                                                         *
# * By Daan Geijsen & Nils Wagemaker                                                                     *
# ********************************************************************************************************
.data
welcome:            .asciz "\nAssignment 1\n====================\nName: Daan Geijsen\nNetID: dgeijsen\nName: Nils Wagemaker\nNetID: nwagemaker\n====================\n\n"
format_int:         .asciz "%ld"                # long decimal (64-bit integer)

.text
.global main


main:
    # prologue
    pushq           %rbp                        # push base pointer to stack
    movq            %rsp, %rbp                  # copy stack pointer to base pointer

    call scan_int

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

    subq            $16, %rsp                   # reserver stack space for variable
    leaq            -16(%rbp), %rsi             # set address of stack variable in %rsi
    movq            $format_int, %rdi           # set first argument of scanf
    movq            $0, %rax                    # no vector registers for scanf
    call            scanf

    # epilogue
    movq            %rbp, %rsp                  # clear local variables from stack
    popq            %rbp                        # restore base pointer location
    ret
