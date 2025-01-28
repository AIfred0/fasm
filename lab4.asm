format ELF64
public _start

include "asmlib/filesys.inc"
include "asmlib/input.inc"
include "asmlib/print.inc"
include "asmlib/math.inc"
include "asmlib/string.inc"
include "asmlib/sys.inc"


section '.data' writable
    ; str1 db "string", 0
    ; str1_len = $ - str1
    ; str2 db "string", 0
    ; str2_len = $ - str2


section '.bss' writable
    buffer1 equ 10
    str1 rb buffer1
    buffer2 equ 10
    str2 rb buffer2


section '.text' executable
_start:
    mov rax, str1   ; text
    mov rbx, buffer1
    call input_string


    push rax
    mov rax, str2   ; target
    mov rbx, buffer2
    call input_string

    mov rbx, rax
    pop rax

    ; mov rax, str1
    ; mov rbx, str2
    call strstr
    call print_number
    call print_enter


    call exit



section '.strstr' executable
; input:
; rax = string
; rbx = string
; output:
; rax = number
strstr:

    push rcx
    push rdx
    push r8
    push r9
    push r10
    push r11


    push rax
    call length_string
    mov rdx, rax    ; text length
    mov rax, rbx
    call length_string
    mov r8, rax     ; pattern length
    dec r8          ; pat len - 1
    pop rax
    mov r9, 0       ; t
    sub rdx, r8     ; text len - pat len + 1
    inc r8          ; pat len

    .for_word:
        cmp r9, rdx ; t < text len - pat len + 1
        je .close

        xor r10, r10    ; p = 0
        jmp .for_sym


    .for_sym:
        cmp r10, r8 ; p < pat len
        je .eq

        mov r11, r9     ; t
        add r11, r10    ; t + p

        cld
        lea rsi, [rax+r11]  ; text[t+p]
        lea rdi, [rbx+r10]  ; pat[p]
        mov rcx, 1  
        repe cmpsb
        jnz .eq


        inc r10     ; p++
        jmp .for_sym
    
    .eq:
        cmp r10, r8 ; p == pat len
        je .ans

        inc r9      ; t++
        jmp .for_word        

    .ans:
        mov rax, r9 

        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        ret

    .close:
        mov rax, -1
        
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        ret