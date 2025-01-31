format ELF64

public fcreate
public fdelete
public fopen
public fclose
public fwrite
public fread
public fseek


section '.bss' writable
    _BUFFER_FILE_SIZE equ 50
    _BUFFER db _BUFFER_FILE_SIZE


section '.fcreate' executable
; input 
; rax = filename
; rbx = permissions
; output:
; rax = descriptor
fcreate:
    push rbx
    push rcx

    mov rcx, rbx
    mov rbx, rax
    mov rax, 8  ; create
    int 0x80    ; system call

    pop rcx
    pop rbx
    ret


section '.fdelete' executable
; input:
; rax = filename
fdelete:
    push rax
    push rbx

    mov rbx, rax
    mov rax, 10 ; unlink
    int 0x80

    pop rbx
    pop rax
    ret


section '.fopen' executable
; input:
; rax = filename
; rbx = mode
; ; O_RDONLY = 0
; ; O_WRONLY = 1
; ; O_RDWR = 2
; output:
; rax = descriptor
fopen:
    push rbx
    push rcx

    mov rcx, rbx
    mov rbx, rax
    mov rax, 5  ; open
    int 0x80

    pop rcx
    pop rbx
    ret


section '.fclose' executable
; input:
; rax = descriptor
fclose:
    push rbx

    mov rbx, rax
    mov rax, 6  ; close
    int 0x80

    pop rbx
    ret


section '.fwrite' executable
; input: 
; rax = descriptor
; rbx = data
; rcx = data size
fwrite:
    push rax
    push rbx
    push rcx
    push rdx


    push rbx
    push rcx

    mov rbx, 1  ; mode
    xor rcx, rcx
    call fseek

    pop rcx
    pop rbx

    mov rdx, rcx
    mov rcx, rbx
    mov rbx, rax
    mov rax, 4  ; write
    int 0x80

    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret


section '.fread' executable
; input:
; rax = descriptor
; rbx = buffer
; rcx = buffer size
fread:
    push rax
    push rbx
    push rcx
    push rdx


    push rbx
    push rcx

    mov rbx, 1  ; mode
    xor rcx, rcx
    call fseek

    pop rcx
    pop rbx

    mov rdx, rcx
    mov rcx, rbx
    mov rbx, rax
    mov rax, 3  ; read
    int 0x80

    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret


section '.fseek' executable
; input:
; rax = descriptor
; rbx = mode seek
; ; SEEK_SET = 0 - смещение с самого начала указания позиции
; ; SEEK_CUR = 1 - продолжить чтение
; ; SEEK_END = 2 - указание на конец файла
; rcx = position
fseek:
    push rax
    push rbx
    push rdx
    

    mov rdx, rbx
    mov rbx, rax
    mov rax, 19 ; seek (смещение указателя)
    int 0x80

    pop rdx
    pop rbx
    pop rax
    ret