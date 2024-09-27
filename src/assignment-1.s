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

.global             main
main:
    # prologue
    pushq           %rbp                        # push base pointer to stack
    movq            %rsp, %rbp                  # copy stack pointer to base pointer

    movq            $welcome, %rdi              # load $welcome string as first printf parameter
    movq            $0, %rax                    # no vector registers for printf
    call            printf


    subq            $16, %rsp                   # reserve stack space for getting input from user (16-byte alligned)

    movq            $prompt_base, %rdi          # load $prompt_base string as first printf parameter
    movq            $0, %rax                    # no vector registers for printf
    call            printf
    call            scan_int
    movq            %rax, -8(%rbp)              # copy the result (base) from scan_int to first half of stack variable

    movq            $prompt_exponent, %rdi      # load $prompt_exponent as first parameter for printf
    movq            $0, %rax                    # no vector registers for printf
    call            printf
    call            scan_int
    movq            %rax, -16(%rbp)             # copy the result (exponent) from scan_int to second half of stack variable
    
    movq            -8(%rbp), %rdi              # load base stack variable as first pow parameter
    movq            -16(%rbp), %rsi             # laod exponent stack variable as second pow parameter
    call            pow

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
# * Subroutine: pow                                                                                      *
# * Description: Calculates base to the power of exponent                                                *
# * Parameters: %rdi = base, %rsi = exponent                                                             *
# * Returns: Returns base to the power of exponetn stored in %rax                                        *
# ********************************************************************************************************
pow:
    # prologue
    pushq           %rsp                        # push base pointer to stack
    movq            %rsp, %rbp                  # copy stack pointer to base pointer


    movq            $1, %rax                    # copy $1 into %rax to make sure that if the exponent is 0 that the result will be 1
    cmpq            $0, %rsi                    # compare $0 and %rsi to check is exponent is 0
    jle             .end                        # jump to .end if exponent is 0

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
