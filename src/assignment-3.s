# ********************************************************************************************************
# * Assignment 3                                                                                         *
# * By Daan Geijsen & Nils Wagemaker                                                                     *
# ********************************************************************************************************

.data

id_str:             .asciz "\nAssignment 3\n====================\nName: Daan Geijsen\nNetID: dgeijsen\nName: Nils Wagemaker\nNetID: nwagemaker\n====================\n\n"
format:             .asciz "%c"

.text

.include            "final.s"

# ********************************************************************************************************

.global main
main:
    # prologue
    pushq           %rbp                        # push base pointer to stack
    movq            %rsp, %rbp                  # copy stack pointer to base pointer

    movq            $id_str, %rdi               # load $welcome string as first printf parameter
    movq            $0, %rax                    # no vector registers for printf
    call            printf

    movq            $MESSAGE, %rdi              # load $MESSAGE as first decode parameter
    call            decode

    movq            %rbp, %rsp
    popq            %rbp                        # restore base pointer
    movq            $0, %rdi                    # set 0 as exit code
    call            exit                        # call exit
    ret

# *******************************************************************************************************

# ********************************************************************************************************
# * Subroutine: decode                                                                                   *
# * Parameters: %rdi = memory address of MESSAGES                                                        *
# * Description: prints decoded message to terminal                                                      *
# ********************************************************************************************************
decode:
    # prologue
    pushq           %rbp                      # push base pointer to stack
    movq            %rsp, %rbp                # copy stack pointer to base pointer

    pushq           %rbx                      # push callee saved register

    movq            %rdi, %rcx
    movq            (%rdi), %rbx              # copy value of value of MESSAGE to %rbx

    0:                                        # begin for loop (looping through quads)
    
    cmpl            $0, %ebx                  # compare destination block to 0
    je              3f                        # jump to end of loop (quad loop)

    movq            (%rdi), %rbx              # copy value of value of MESSAGE to %rbx

    movb            %bl, %sil                 # copy character byte to %sil
    shrq            $8, %rbx                  # shift %rbx 1 byte to the right
    movb            %bl, %dl                  # copy n-characters byte to %dl
    shrq            $8, %rbx                  # shift %rbx 1 byte to the right
    andl            $0xFFFFFF, %ebx           # mask byte 2-6 s.t. we remove byte 2

    1:                                        # begin for loop (looping through n-characters)   

    cmpb            $0, %dl                   # compare 0 to the n-characters counter
    je              2f                        # jump to end of print loop 

    # pushq callee saved values to stack
    pushq           %rcx
    pushq           %rsi
    pushq           %rdi
    pushq           %rdx

    movq            $format, %rdi              # load format string as first print parameter
    andq            $0xFF, %rsi                # mask character register
    movq            $0, %rax                   # no vector registers for printf
    call            printf 

    # popq callee saved values from stack
    popq            %rdx
    popq            %rdi
    popq            %rsi
    popq            %rcx

    decb            %dl                       # decrement n-characters by one
    jmp             1b                        # jump to start of print loop

    2:                                        # end print loop

    leaq            (%rcx, %rbx, 8), %rdi     # calculate memory address of MESSAGES + block * 8 and store it in %rdi
    jmp             0b                        # jump to quad loop

    3:

    popq            %rbx                      # pop callee saved register

    # epilogue
    movq            %rbp, %rsp                # clear local variables
    popq            %rbp                      # restore base pointer locatio
    ret

# ********************************************************************************************************
