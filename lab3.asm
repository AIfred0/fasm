format ELF64
public _start

include "asmlib/filesys.inc"
include "asmlib/input.inc"
include "asmlib/print.inc"
include "asmlib/math.inc"
include "asmlib/string.inc"
include "asmlib/sys.inc"

section '.data' writable
    filename db "SUMDIGITIN.txt", 0
    filename2 db "SUMDIGITOUT.txt", 0

section '.bss' writable
    buffer_size equ 50
    buffer db buffer_size


section '.text' executable
_start:
    ; открытие
    mov rax, filename
    mov rbx, 2
    call fopen

    ; чтение из файла
    mov rbx, buffer
    mov rcx, buffer_size
    call fread
    call fclose

    ; решение задачи
    mov rax, buffer
    call max_sum_num
    call number_to_string
    mov rax, buffer
    push rax
    call length_string
    mov rcx, rax

    ; создание и запись файла ответа
    mov rax, filename2
    mov rbx, 777o
    call fcreate
    pop rbx
    call fwrite


    call fclose
    call exit


section '.max_sum_num' executable
; input:
; rax = string
; output:
; rax = number
max_sum_num:
    push rdi
    push rcx
    push rdx
    push rsi
    push rbx
    push r8

    mov rcx, rax    ; string
    xor rax, rax    ; for call
    xor rdi, rdi    ; i
    xor rdx, rdx    ; now sum
    xor rsi, rsi    ; max sum
    xor rbx, rbx    ; now num
    xor r8, r8      ; ans
    
    .crop:
        cmp [rcx+rdi], byte 0xA
        
        je .ok
        inc rdi
        jmp .crop

    .ok:
        inc rdi
        jmp .next_iter

    .next_iter:
        cmp [rcx+rdi], byte 0
        je .close
        cmp [rcx+rdi], byte " "
        je .break

        mov al, [rcx+rdi]
        sub al, '0'

        imul rbx, 10
        add rbx, rax
        add rdx, rax


        inc rdi 
        jmp .next_iter
    .break:
        cmp rdx, rsi
        jg .swap
        xor rdx, rdx
        xor rbx, rbx
        inc rdi
        jmp .next_iter

    .swap:
        mov rsi, rdx
        xor rdx, rdx
        mov r8, rbx
        xor rbx, rbx
        inc rdi
        jmp .next_iter

    .close:
        cmp rdx, rsi
        jg .fin_swap
        
        mov rax, r8
        pop r8
        pop rbx
        pop rsi
        pop rdx
        pop rcx
        pop rdi
        ret

    .fin_swap:
        mov rax, rbx
        pop r8
        pop rbx
        pop rsi
        pop rdx
        pop rcx
        pop rdi
        ret