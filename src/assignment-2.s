# ********************************************************************************************************
# * Assignment 2                                                                                         *
# * By Daan Geijsen & Nils Wagemaker                                                                     *
# ********************************************************************************************************

.data

idstr:              .asciz "\nAssignment 2\n====================\nName: Daan Geijsen\nNetID: dgeijsen\nName: Nils Wagemaker\nNetID: nwagemaker\n====================\n\n"
inputformat:        .asciz "%ld"

prompt:             .asciz "> "
output:             .asciz "> %ld\n"

.text

# ********************************************************************************************************

.global             main
main:
    # prologue
    pushq           %rbp                        # push base pointer to stack
    movq            %rsp, %rbp                  # copy stack pointer to base pointer

    movq            $idstr, %rdi                # load $welcome string as first printf parameter
    movq            $0, %rax                    # no vector registers for printf
    call            printf

    movq            $prompt, %rdi               # load $prompt string as first printf parameter
    movq            $0, %rax                    # no vector registers for printf
    call            printf
    call            scan_int    

    movq            %rax, %rdi                  # load scanf output as first factorial parameter
    movq            $1, %rax                    # set default %rax value
    call            factorial

    movq            $output, %rdi               # load $output string as first printf parameter
    movq            %rax, %rsi                  # load factorial output as second printf parameter
    movq            $0, %rax                    # no vector registers for printf
    call            printf

    # epilogue
    movq            %rbp, %rsp                  # clear local variables from stack
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

    movq            $inputformat, %rdi          # load first scanf parameter
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
    pushq           %rbp                        # push base pointer to the stack
    movq            %rsp, %rbp                  # copy stack pointer to the base pointer

    cmpq            $1, %rdi                    # compare $1 to %rsi
    jg              0f                          # if n >= 1 jump to .0
    jmp             1f                          # else jump to .1

    0:                                          # if n >= 1
    mulq            %rdi                        # multiply %rax by %rdi
    decq            %rdi                        # decrement %rdx by one
    call            factorial   
    1:                                          # else

    # epilogue
    movq            %rbp, %rsp                  # clear local variables from stack
    popq            %rbp                        # restore base pointer location
    ret

# ********************************************************************************************************
