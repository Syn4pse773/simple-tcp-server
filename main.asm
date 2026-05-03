format ELF64 executable 3
entry start


segment readable executable

AF_INET = 2
SOCK_STREAM = 1

start:
    mov rax, 41
    mov rdi, AF_INET
    mov rsi, SOCK_STREAM
    mov rdx, 0
    syscall

    cmp rax, 0
    jl error_exit



    mov r15, rax


    mov rax, 49
    mov rdi, r15
    mov rsi, serv_addr
    mov rdx, 16
    syscall

    cmp rax, 0
    jl error_exit

    mov rax, 50
    mov rdi, r15
    mov rsi, 5
    syscall
    
    cmp rax, 0
    jl error_exit
    
    mov rsi, msg_ok
    mov rdx, msg_ok_len
    call print_string
    
     
    mov rax, 43
    mov rdi, r15
    mov rsi, 0
    mov rdx, 0  
    syscall
    cmp rax, 0  
    jl error_exit
    mov r14, rax

    mov rsi, msg_client
    mov rdx, msg_client_len
    call print_string

    mov rax, 43
    mov rdi, r15
    mov rsi, 0
    mov rdx, 0
    syscall
    cmp rax, 0
    jl error_exit
    mov r12, rax


    mov rax, 57
    syscall

    cmp rax, 0
    je child_loop

    
    mov rsi, msg_client
    mov rdx, msg_client_len
    call print_string
    
parent_loop:
    mov rax, 0
    mov rdi, r14
    mov rsi, buffer
    mov rdx, 256
    syscall
    cmp  rax, 0
    jle exit
    mov r13, rax

    mov rax, 1
    mov rdi, r12
    mov rsi, prefix1
    mov rdx, prefix1_len
    syscall

    mov rax, 1
    mov rdi, r12
    mov rsi, buffer
    mov rdx, r13
    syscall
    jmp parent_loop
    
    

child_loop:
    mov rax, 0
    mov rdi, r12
    mov rsi, buffer
    mov rdx, 256
    syscall

    cmp rax, 0
    jle exit
    mov r13, rax
    
    mov rax, 1
    mov rdi, r14
    mov rsi, prefix2
    mov rdx, prefix2_len
    syscall
    
    mov rax, 1
    mov rdi, r14
    mov rsi, buffer
    mov rdx, r13
    syscall
    
    jmp child_loop






    
exit:
    mov rax, 60
    xor rdi, rdi
    syscall
close_client:
    mov rax, 3
    mov rdi, r14
    syscall

error_exit:
    mov rsi, msg_err
    mov rdx, msg_err_len
    call print_string 
    jmp exit


print_string:  
    mov rax, 1
    mov rdi, 1
    syscall
    ret

segment readable writeable
    msg_ok db 'Server on port 8080 created', 10
    msg_ok_len = $ - msg_ok
    msg_err db 'closed/failed', 10
    msg_err_len = $ - msg_err
    msg_client db 'client connected', 10
    msg_client_len = $ - msg_client
    prefix1 db '[CLIENT 1]: '
        prefix1_len = $ - prefix1
    prefix2 db '[CLIENT 2]: '
        prefix2_len = $ - prefix2
    buffer rb 256
    serv_addr:
        dw AF_INET
        dw 0x901F
        dd 0
        dq 0
