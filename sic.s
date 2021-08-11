%define NULL 0

section .data
first_format_string: DB "%ld", 0
format_string: DB " %ld", 0
printing_format: DB " %ld", 0
enter_format: DB 10, 0
index: DQ 0
size: DQ 0
print_index: DQ 0
EOF: DQ 0xffffffff

extern printf
extern scanf
extern malloc
extern free
global main

section .bss
num: resb 8
arr: resb 8
new_arr: resb 8

section .text
main:
    push rbp
    mov rbp, rsp

	mov rdi, 4096
    shl rdi, 3
    mov rax, 0
    call malloc
    mov qword [arr], rax
    mov qword[size], 0
    mov qword[index], -1
    mov rdi, first_format_string
    mov rsi, num
    mov rax, 0
    call scanf
    cmp rax, 0
    jle malloc_2
    cmp rax, qword[EOF]
    je malloc_2
    add qword[index], 1
    mov r10, qword[arr]
    mov r14, qword [num]
    mov qword[r10], r14

    loop:
    	mov rdi, format_string
    	mov rsi, num
    	mov rax, 0
    	call scanf
    	cmp rax, 0
    	jle malloc_2
        cmp rax, qword[EOF]
        je malloc_2
    	add qword[index], 1
    	xor r15, r15
        times 8 add r15, qword [index]
    	mov r10, qword[arr]
    	add r10, r15
    	mov r14, qword [num]
    	mov qword[r10], r14
    	jmp loop

    malloc_2:
        mov r10, qword[index]
        cmp r10, -1
        je end
        add qword[index], 1
    	mov r10, qword[index]
        mov qword[size], r10
    	mov rdi, qword[size]
        shl rdi, 3
    	mov rax, 0
    	call malloc
        mov qword[new_arr], rax

    mov rcx, qword[size]
    dec rcx
    mov r10, qword[arr]
    mov r11, qword[new_arr]
    mov r13, qword[r10]
    mov qword[r11], r13
    cmp rcx, 0
    jle skip_copy_array
    xor r14, r14

    copy_array:
        dec rcx
        mov r10, qword[arr]
        mov r11, qword[new_arr]
        add r14, 8
        add r10, r14
        add r11, r14
        mov r13, qword[r10]
        mov qword[r11], r13
        cmp rcx, 0
        jg copy_array

    skip_copy_array:
        mov qword[index], 0
        mov r15, qword[new_arr]
        xor r8, r8
        xor r9, r9
        xor r10, r10

    SBN:
        mov r9, r8
        add r9, 8
        mov r10, r9
        add r10, 8
        mov rcx, r15
        add rcx, r8
        cmp qword[rcx], NULL
        jne continue_SBN
        mov rcx, r15
        add rcx, r9
        cmp qword[rcx], NULL
        jne continue_SBN
        mov rcx, r15
        add rcx, r10
        cmp qword[rcx], NULL
        jne continue_SBN
        je print

    continue_SBN:
        mov rcx, r15
        add rcx, r8
        mov r12, qword[rcx]         ;r12 is M[i]
        shl r12, 3
        mov rcx, r15
        add rcx, r9
        mov r13, qword[rcx]         ;r13 is M[i+1]
        shl r13, 3
        mov rcx, r15
        add rcx, r12                ;rcx is M[M[i]]
        mov rdi, r15
        add rdi, r13
        mov rdi, qword[rdi]         ;rdi is M[M[i+1]]
        sub qword[rcx], rdi
        cmp qword[rcx], 0
        jl change_index
        add r8, 24
        jmp SBN

    change_index:
        mov rcx, r15
        add rcx, r10
        mov r14, qword[rcx]         ;r14 is M[i+2]
        shl r14, 3
        mov r8, r14
        jmp SBN
    
    print:
        mov rcx, qword[size]
        mov r15, qword[new_arr]
        mov qword [print_index], rcx
        sub qword[print_index], 1
        mov rdi, first_format_string
        mov rsi, qword [r15]
        mov rax, 0
        call printf
        mov qword[index], 1

        print_loop:
            xor r14, r14
            times 8 add r14, qword[index]
            add qword[index], 1
            sub qword [print_index], 1 
        	mov rdi, printing_format
        	mov rsi, qword [r15+r14]
        	mov rax, 0
            call printf
            mov rcx, qword[print_index]
            cmp rcx, 0
            jg print_loop

        mov rdi, enter_format
        mov rax, 0
        call printf

	end:
        mov rdi, qword[arr]
        call free
        mov rdi, qword[new_arr]
        call free
    	mov rsp, rbp
    	pop rbp
ret