# ********************************************************************************************************
# * Assignment 3                                                                                         *
# * By Daan Geijsen & Nils Wagemaker                                                                     *
# ********************************************************************************************************

.data

id_str:             .asciz "\nAssignment 3\n====================\nName: Daan Geijsen\nNetID: dgeijsen\nName: Nils Wagemaker\nNetID: nwagemaker\n====================\n\n"
format_str:         .asciz "%c"

hello:              .asciz "hello world\n"

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

    movq            $"hello world\n", %r10

    movq            $1, %rax
    movq            $1, %rdi
    movq            %r10, %rsi
    movq            $12, %rdx
    syscall

    # epilogue
    movq            %rbp, %rsp                  # clear local variables
    popq            %rbp                        # restore base pointer location
    movq            $0, %rdi                    # set 0 as exit code
    call            exit
    ret

# ********************************************************************************************************
