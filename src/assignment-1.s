# ********************************************************************************************************
# * Assignment 1                                                                                         *
# * By Daan Geijsen & Nils Wagemaker                                                                     *
# ********************************************************************************************************

.text
welcome:                .asciz "\nAssignment 1\n====================\nName: Daan Geijsen\nNetID: dgeijsen\nName: Nils Wagemaker\nNetID: nwagemaker\n====================\n\n"
prompt_base:            .asciz "Enter a non-negative base:\n"
prompt_exponent:        .asciz "Enter a non-negative exponent:\n"
format_str:       .asciz "%ld"
output:                 .asciz "> %ld\n"

.global main



main:
    # prologue
    pushq               %rbp                                    # push base pointer to stack
    movq                %rsp, %rbp                              # copy stack pointer to base pointer

    movq                $welcome, %rdi                          # set $welcome string as first parameter
    call                printf
    


    movq                $0, %rdi                                # clear base
    movq                $0, %rsi                                # clear exponent

    movq                $prompt_base, %rdi                      # set printf parameter
    call                printf
    #call                scan_int
    movq                %rsi, %rdi                              # copy scanf return value into %rdi for pow

    movq                $prompt_exponent, %rdi                  # set printf parameter
    call                printf
    #call                scan_int                                # no need to copy into %rsi because that is where scanf leaves stuff

    call                pow
    movq                $output, %rdi                           # set prompt as first parameter
    movq                %rax, %rsi                              # set pow return value as second parameter   
    call                printf



    # epilogue
    movq                %rbp, %rsp                              # copy base pointer to stack pointer
    popq                %rbp                                    # pop base pointer from stack

    movq                $0, %rdi                                # set 0 as exit code
    call                exit



# ********************************************************************************************************
# * Subroutine: pow                                                                                      *
# * Description: calculates non-negative base to the power of non-negative exponent                      *
# * Parameters: %rdi = base, %rsi = exponent                                                             *
# * Returns: base to the power of the exponent                                                           *
# ********************************************************************************************************
pow:
    # prologue
    pushq               %rsp                                    # push base pointer to stack
    movq                %rsp, %rbp                              # copy stack pointer to base pointer

    movq                %rdi, %rax                              # copy base to %rax to be multiplied

    .loop:                                                      # loop as long as exponent > 0
    cmpq                $1, %rsi                                # compare exponent to 0
    jle                 .end                                    # jump to .end if loop is finished
    decq                %rsi                                    # decrement exponent by one

    mulq                %rdi                                    # multiply %rax by base
    
    jmp                 .loop                                   # jump to loop
    .end:

    # epilogue
    movq                %rbp, %rsp                              # copy base pointer to stack pointer
    popq                %rbp                                    # pop base pointer from stack
    ret



# ********************************************************************************************************
# * Subroutine: scan_int                                                                                 *
# * Description: calls scanf of standard library to scan for integer                                     *
# ********************************************************************************************************
scan_int:
    # prologue
    pushq               %rsp                                    # push base pointer to stack
    movq                %rsp, %rbp                              # copy stack pointer to base pointer

    subq                $8, %rsp                                # reserve space on stack
    leaq                -8(%rbp), %rsi                          # load address of stack var in %rsi  
    movq                $format_str, %rdi                       # set first argument of scanf
    movq                $0, %rax
    call                scanf        

    # epilogue
    movq                %rbp, %rsp                              # copy base pointer to stack pointer
    popq                %rbp                                    # pop base pointer from stack
    ret

ret
