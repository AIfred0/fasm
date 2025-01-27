format ELF64

public input_char
public input_number
public input_string

include "string.inc"

section '.bss' writable
    _BUFFER_CHAR_SIZE equ 2
    _BUFFER_CHAR rb _BUFFER_CHAR_SIZE

    _BUFFER_NUMBER_SIZE equ 21
    _BUFFER_NUMBER rb _BUFFER_NUMBER_SIZE
    
    ; buffer_size equ 20
    ; buffer rb buffer_size


section '.input_char' executable
; ouput:
; rax = char
input_char:
    mov rax, _BUFFER_CHAR
    mov rbx, _BUFFER_CHAR_SIZE
    call input_string
    mov rax, [rax]
    ret


section '.input_number' executable
; output:
; rax = number
input_number:
    mov rax, _BUFFER_NUMBER
    mov rbx, _BUFFER_NUMBER_SIZE
    call input_string
    call string_to_number
    ret



section '.input_string' executable
; input:
; rax = buffer
; rbx = buffer size
; output:
; rax = string
input_string:
    push rax
    push rbx
    push rcx
    push rdx

    push rax

    mov rcx, rax
    mov rdx, rbx
    mov rax, 3  ; read
    mov rbx, 2  ; stdin
    int 0x80

    pop rbx
    mov [rbx+rax-1], byte 0

    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret