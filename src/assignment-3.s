# ************************************
# * Assignment 3                                                                                         *
# * By Daan Geijsen & Nils Wagemaker                                                                     *
# ************************************

.include            "assignment-3/hello_world.s"

.bss
char:               .byte 0
xchar:              .byte 0

.data
welcome:            .asciz "\nAssignment 3\n====================\nName: Daan Geijsen\nNetID: dgeijsen\nName: Nils Wagemaker\nNetID: nwagemaker\n====================\n\n"
format:             .asciz "%c"                 # format for printing numeric character value

.text
.global             main

main:
    # prologue
    pushq           %rbp                        # push the base pointer to the stack
    movq            %rsp, %rbp                  # copy the stack pointer to the base pointer

    movq            $welcome, %rdi              # set welcome message
    movq            $0, %rax                    # no vector registers for printf
    call            printf


    call            decode


    # epilogue
    movq            %rbp, %rsp                  # clear local variables from stack
    popq            %rbp                        # pop the base pointer from the stack
    movq            $0, %rdi                    # set 0 as exit code
    call            exit


decode:
    # prologue
    pushq           %rbp                        # push the base pointer to the stack
    movq            %rsp, %rbp                  # copy the stack pointer to the base pointer


    movq            block, %rdi
    movq            MESSAGE, %rsi

    leaq            (%rsi, %rdi, 8), %rax               # copy memory address of message into %rax

    .start_decode:
    movq            -8(%r9), %rax

    movb            %al, char                   # copy byte 8 into char label
    shrq            $8, %rax                    # shift the message 1 byte to the right

    movb            %al, xchar                  # copy byte 7 to xchar label
    shrq            $8, %rax                    # shift the message 1 byte to the right

    andl            $0x00FFFFFF, %eax           # mask byte 2-6 s.t. we remove byte 2
    movl            %eax, %edx                  # copy byte 2-6 to %rdx

    .print_loop:
    cmpb            $1, xchar
    jl              0f

    movq            $format, %rdi               # copy format to first parameter for printf
    movb            char, %sil                  # copy character to second parameter for printf
    movq            $0, %rax                    # no vector registers for printf
    call            printf

    decb            xchar
    jmp             0f

    0:
    subq            $0, block
    jle             1f
    jmp             .start_decode

    1:
    # epilogue
    movq            %rsp, %rbp                  # clear local variables from stack
    popq            %rbp                        # pop the base pointer from the stack
    ret