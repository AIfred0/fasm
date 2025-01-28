format ELF64
public _start

include "asmlib/input.inc"
include "asmlib/math.inc"
include "asmlib/print.inc"
include "asmlib/string.inc"
include "asmlib/sys.inc"

section '.text' executable
_start:
    call input_number
    call goldbach
    call print_enter
    call exit



section '.goldbach' executable
; input:
; rax = number
goldbach:
    push rbx
    push rcx
    push rdx
    mov rcx, 2  ; first
    .first_number:
        cmp rax, rcx
        je .close
        xor rdx, rdx
        push rax
        mov rax, rcx
        call simple
        mov rdx, rax
        pop rax
        cmp rdx, 1
        je .second_number
        
        inc rcx
        jmp .first_number

        .second_number:
            mov rbx, rax
            sub rbx, rcx
            push rax
            mov rax, rbx
            call simple
            mov rdx, rax
            pop rax
            cmp rdx, 1
            je .close
            inc rcx
            jmp .first_number

    .close:
        mov rax, rcx
        call print_number
        mov al, ' '
        call print_char
        mov rax, rbx
        call print_number


        pop rdx
        pop rcx
        pop rbx
        ret