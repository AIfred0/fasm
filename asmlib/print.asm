format ELF64

public print_number
public print_string
public print_char
public print_enter
public print_bytes

include "string.inc"

section '.bss' writable
    _BSS_CHAR rb 1

section '.print_number' executable
; input:
; rax = number
print_number:
    push rax
    push rbx
    push rcx
    push rdx
    xor rcx, rcx
    .next_iter:
        mov rbx, 10
        xor rdx, rdx
        div rbx       
        add rdx, '0'   
        push rdx
        inc rcx         
        cmp rax, 0
        je .print_iter  
        jmp .next_iter
    .print_iter:
        cmp rcx, 0
        je .close
        pop rax
        call print_char
        dec rcx         
        jmp .print_iter
    .close:
        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret


section '.print_char' executable
; input:
; rax = char
print_char:
    push rdx
    push rcx
    push rbx
    push rax

    mov [_BSS_CHAR], al
    
    mov rax, 4
    mov rbx, 1
    mov rcx, _BSS_CHAR
    mov rdx, 1
    int 0x80
    
    pop rax
    pop rbx
    pop rcx
    pop rdx
    ret


section '.print_string' executable
; input:
; rax = string
print_string:
    push rax
    push rbx
    push rcx
    push rdx
    mov rcx, rax
    call length_string
    mov rdx, rax
    mov rax, 4
    mov rbx, 1
    int 0x80
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret


section '.print_enter' executable
print_enter:
    push rax
    mov rax, 0xA    
    call print_char
    pop rax
    ret


section '.print_bytes' executable
; input:
; rax = array
; rbx = array size
print_bytes:
    push rax
    push rbx
    push rcx
    mov rcx, rax
    xor rax, rax
    mov al, '['
    call print_char
    mov al, ' '
    call print_char
    .next_iter:
        cmp rbx, 0
        je .close
        mov al, [rcx]
        call print_number
        mov al, ' '
        call print_char
        inc rcx
        dec rbx
        jmp .next_iter
    .close:
        mov al, ']'
        call print_char
        pop rcx
        pop rbx
        pop rax
        ret