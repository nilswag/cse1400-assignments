# ********************************************************************************************************
# * Assignment 3                                                                                         *
# * By Daan Geijsen & Nils Wagemaker                                                                     *
# ********************************************************************************************************

.data

id_str:             .asciz "\nAssignment 3\n====================\nName: Daan Geijsen\nNetID: dgeijsen\nName: Nils Wagemaker\nNetID: nwagemaker\n====================\n\n"
format:             .asciz "%c"

.text

.include            "abc_sorted.s"

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
    movq            %rdi, %rcx

    subq            $8, %rsp
    pushq           %rbx
    call            decode
    popq            %rbx
    addq            $8, %rsp

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

    0:

    cmpl            $0, %ebx
    je              3f

    movq            (%rdi), %rbx              # copy value of value of MESSAGE to %rbx

    movb            %bl, %sil                 # copy character byte to %sil
    shrq            $8, %rbx                  # shift %rbx 1 byte to the right
    movb            %bl, %dl                  # copy n-characters byte to %dl
    shrq            $8, %rbx                  # shift %rbx 1 byte to the right
    andl            $0xFFFFFF, %ebx           # mask byte 2-6 s.t. we remove byte 2

    1:

    cmpb            $0, %dl
    je              2f

    pushq           %rcx
    pushq           %rsi
    pushq           %rdi
    pushq           %rdx

    movq            $format, %rdi
    andq            $0xFF, %rsi
    movq            $0, %rax
    call            printf

    popq            %rdx
    popq            %rdi
    popq            %rsi
    popq            %rcx

    decb            %dl                       # decrement %dl by one
    jmp             1b

    2:

    leaq            (%rcx, %rbx, 8), %rdi     # calculate memory address of MESSAGES + block * 8 and store it in %rdi
    jmp             0b

    3:

    # epilogue
    movq            %rbp, %rsp                # clear local variables
    popq            %rbp                      # restore base pointer locatio
    ret

# ********************************************************************************************************
