# ********************************************************************************************************
# * Assignment 2                                                                                         *
# * By Daan Geijsen & Nils Wagemaker                                                                     *
# ********************************************************************************************************
.data
welcome:            .asciz "\nAssignment 2\n====================\nName: Daan Geijsen\nNetID: dgeijsen\nName: Nils Wagemaker\nNetID: nwagemaker\n====================\n\n"
format_int:         .asciz "%ld"                # long decimal (64-bit integer)
prompt:             .asciz "Enter a non-negative integer:\n"
output:             .asciz "> %ld\n"    

.text
.global             main



main:
    # prologue
    pushq           %rbp                        # push base pointer to stack
    movq            %rsp, %rbp                  # copy stack pointer to base pointer

    movq            $welcome, %rdi              # load $welcome string as first printf parameter
    movq            $0, %rax                    # no vector registers for printf
    call            printf


    subq            $16, %rsp                   # reserve stack space for getting input from user (16-byte alligned)

    movq            $prompt, %rdi          # load $prompt_base string as first printf parameter
    movq            $0, %rax                    # no vector registers for printf
    call            printf
    call            scan_int
    movq            %rax, -8(%rbp)              # copy the result (integer for factorial) from scan_int to first half of stack variable
    movq            -8(%rbp), %rdi              # load base stack variable as factorial parameter
    call            factorial

    movq            $output, %rdi               # load $output string as first printf parameter
    movq            %rax, %rsi                  # load result from pow as second printf parameter
    movq            $0, %rax                    # no vector registers for printf
    call            printf


    # epilogue
    movq            %rbp, %rsp                  # clear local variables from stack
    popq            %rbp                        # restore base pointer location
    movq            $0, %rdi                    # set 0 as exit code
    call            exit
    ret



# ********************************************************************************************************
# * Subroutine: scan_int                                                                                 *
# * Description: Scans user input for integer (converts integer to unsigned if signed)                   *
# * Returns: Returns user input stored in %rax                                                           *
# ********************************************************************************************************
scan_int:
    # prologue
    pushq           %rbp                        # push base pointer to stack
    movq            %rsp, %rbp                  # copy stack pointer to base pointer


    subq            $16, %rsp                   # reserve stack space for getting input from user (16-byte aligned)
    movq            $format_int, %rdi           # load $format_int string as first scanf parameter
    leaq            -16(%rbp), %rsi             # copy stack space address into second scanf parameter
    movq            $0, %rax                    # no vector registers for scanf
    call            scanf
    movq            %rsi, %rax                  # set the stack space variable address as return value for pow


    # epilogue
    movq            %rbp, %rsp                  # clear local variables from stack
    popq            %rbp                        # restore base pointer location
    ret



# ********************************************************************************************************
# * Subroutine: factorial                                                                                *
# * Description: Calculates factorial of the parameter n                                                 *
# * Parameters: %rdi = n                                                                                 *
# * Returns: Returns factorial of parameter n stored in %rax                                             *
# ********************************************************************************************************
factorial:
    # prologue
    pushq           %rbp                        # push base pointer to stack
    movq            %rsp, %rbp                  # copy stack pointer to base pointer


    #movq            %rdi, %rax                  # copy parameter n into %rax to be multiplied
    cmpq            $1, %rdi                    # compares $1 the parameter n
    jle             .end                        # if n <= 1 jump to .end

    decq            %rdi                        # decrement parameter n by one
    mulq            %rdi                        # multiply %rax by parameter n
    call            factorial
    .end:


    # epilogue
    movq            %rbp, %rsp                  # copy base pointer to stack pointer
    popq            %rbp                        # pop base pointer from stackr
    ret
