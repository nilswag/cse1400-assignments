# ********************************************************************************************************
# * Assignment 3                                                                                         *
# * By Daan Geijsen & Nils Wagemaker                                                                     *
# ********************************************************************************************************

.data

id_str:             .asciz "\nAssignment 3\n====================\nName: Daan Geijsen\nNetID: dgeijsen\nName: Nils Wagemaker\nNetID: nwagemaker\n====================\n\n"
format_str:         .asciz "%c"

.text

.include            "assignment-3/hello_world.s"

# ********************************************************************************************************

.global main
main:
    # prologue
    pushq           %rbp                        # push base pointer to stack
    movq            %rsp, %rbp                  # copy stack pointer to base pointer
  
    movq            $id_str, %rdi               # load $welcome string as first printf parameter
    movq            $0, %rax                    # no vector registers for printf
    call            printf

    movq            $MESSAGE, %rdi             # load $MESSAGE as first decode parameter
    movq            %rdi, %rcx

    
    call            decode

    # epilogue
    movq            %rbp, %rsp                  # clear local variables
    popq            %rbp                        # restore base pointer location
    movq            $0, %rdi                    # set 0 as exit code
    call            exit
    ret

# ********************************************************************************************************

# ********************************************************************************************************
# * Subroutine: decode                                                                                   *
# * Parameters: %rdi = memory address of MESSAGES                                                        *
# * Description: prints decoded message to terminal                                                      *
# ********************************************************************************************************
decode:
    # prologue
    pushq           %rbp                      # push base pointer to stack
    movq            %rsp, %rbp                # copy stack pointer to base pointer

    pushq           %rbx
    movq            (%rdi), %rbx              # copy value of value of MESSAGE to %rbx

    movb            %bl, %sil                 # copy character byte to %r13b
    shrq            $8, %rbx                  # shift %rbx 1 byte to the right
    movb            %bl, %dl                  # copy n-characters byte to %r12b
    shrq            $8, %rbx                  # shift %rbx 1 byte to the right
    andl            $0xFFFFFF, %ebx           # mask byte 2-6 s.t. we remove byte 2

    0:

    cmpb            $0, %dl                   # compare 0 to %r12b
    jle             1f                        # if %r12b == 0 then end the loop

    decb            %dl                       # decrement %r12b by one
    jmp             0b

    1:

    cmpl            $0x0, %ebx                # compare next memory block to 0x0
    je              2f                        # if block == 0x0 then return    

    leaq            (%rcx, %rbx, 8), %rdi     # calculate memory address of MESSAGES + block * 8 and store it in %rdi
    call            decode

    2:

    popq            %rbx

    # epilogue
    movq            %rbp, %rsp                # clear local variables
    popq            %rbp                      # restore base pointer locatio
    ret
