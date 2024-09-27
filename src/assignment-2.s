# ********************************************************************************************************
# * Assignment 2                                                                                         *
# * By Daan Geijsen & Nils Wagemaker                                                                     *
# ********************************************************************************************************

.data

id_str:             .asciz "\nAssignment 2\n====================\nName: Daan Geijsen\nNetID: dgeijsen\nName: Nils Wagemaker\nNetID: nwagemaker\n====================\n\n"
input_format:       .asciz "%ld"

input_prompt:       .asciz "> "
output_prompt:      .asciz "> %ld\n"

.text

# ********************************************************************************************************

.global main
main:
    # prologue
    pushq           %rbp                        # push base pointer to stack
    movq            %rsp, %rbp                  # copy stack pointer to base pointer

    movq            $id_str, %rdi               # load $welcome string as first printf parameter
    movq            $0, %rax                    # no vector registers for printf
    call            printf

    movq            $input_prompt, %rdi         # load $prompt string as first printf parameter
    movq            $0, %rax                    # no vector registers for printf
    call            printf
    call            scan_int

    movq            %rax, %rdi                  # load user input as factorial parameter
    call            factorial

    movq            $output_prompt, %rdi        # load $output string as first printf parameter
    movq            %rax, %rsi                  # load factorial output as second printf parameter
    movq            $0, %rax                    # no vector registers for printf
    call            printf

    # epilogue
    movq            %rbp, %rsp                  # clear local variables
    popq            %rbp                        # restore base pointer location
    movq            $0, %rdi                    # set 0 as exit code
    call            exit
    ret

# ********************************************************************************************************

# ********************************************************************************************************
# * Subroutine: scan_int                                                                                 *
# * Description: scans user input for integer (converts integer to unsigned if signed)                   *
# * Returns: returns user input stored in %rax                                                           *
# ********************************************************************************************************
scan_int:
    # prologue
    pushq           %rbp                        # push base pointer to stack
    movq            %rsp, %rbp                  # copy stack pointer to base pointer

    subq            $16, %rsp                   # allocate memory for scanf

    movq            $input_format, %rdi         # load first scanf parameter
    leaq            -8(%rbp), %rsi              # load second scanf parameter
    movq            $0, %rax                    # no vector registers for scanf
    call            scanf

    movq            -8(%rbp), %rax              # copy scanf return value into %rax

    # epilogue
    movq            %rbp, %rsp                  # clear local variables from stack
    popq            %rbp                        # restore base pointer location
    ret

# ********************************************************************************************************

# ********************************************************************************************************
# * Subroutine: factorial                                                                                *
# * Description: calculates factorial of n                                                               *
# * Parameters: %rdi as n                                                                                *
# * Returns: factorial of n                                                                              *
# ********************************************************************************************************
factorial:
    # prologue
    pushq           %rbp                        # push base pointer to stack
    movq            %rsp, %rbp                  # copy stack pointer to base pointer

    cmpq            $1, %rdi                    # compare 1 to n
    jg              0f                          # if n > 1 jump to recursive step
    movq            $1, %rax                    # else return 1
    jmp             1f
    0:                                          # recursive step
    subq            $8, %rsp                    # keep stack aligned
    pushq           %rdi                        # push n to stack
    decq            %rdi                        # decrement n by one
    call            factorial
    popq            %rdi                        # pop n from stack
    mulq            %rdi                        # multiply %rax by n

    1:                                          # end
    # epilogue
    movq            %rbp, %rsp                  # clear local variables from stack
    popq            %rbp                        # restore base pointer location
    ret

# ********************************************************************************************************
