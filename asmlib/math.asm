format ELF64

; public gcd
; public fibonacci
; public factorial
; public bubble_sort
public simple
; public goldbach

; section '.gcd' executable
; gcd:
;     push rbx
;     push rdx
;     .next_iter:
;         cmp rbx, 0
;         je .close
;         xor rdx, rdx
;         div rbx
;         push rbx
;         mov rbx, rdx
;         pop rax
;         jmp .next_iter
;     .close:
;         pop rdx
;         pop rbx
;         ret


; section '.fibonacci' executable
; fibonacci:
;     push rbx
;     push rcx
;     mov rbx, 0
;     mov rcx, 1
;     cmp rax, 0
;     je .next_step 
;     .next_iter:
;         cmp rax, 1
;         jle .close
;         push rcx
;         add rcx, rbx
;         pop rbx
;         dec rax
;         jmp .next_iter
;     .next_step:
;         xor rcx, rcx
;     .close:
;         mov rax, rcx
;         pop rcx
;         pop rbx
;         ret


; section '.factorial' executable
; factorial:
;     push rbx
;     mov rbx, rax
;     mov rax, 1
;     .next_iter:
;         cmp rbx, 1
;         jle .close
;         mul rbx
;         dec rbx
;         jmp .next_iter
;     .close:
;         pop rbx
;         ret


; section '.bubble_sort' executable
; ; input:
; ; rax = array
; ; rbx = array size
; bubble_sort:
;     push rbx
;     push rcx
;     push rdx
;     xor rcx, rcx    ; i
;     .first_iter:
;         cmp rcx, rbx
;         je .break_first
;         xor rdx, rdx    ; j
;         push rbx
;         sub rbx, rcx
;         dec rbx
;         .second_iter:
;             cmp rdx, rbx
;             je .break_second
;             push rbx
;             mov bl, [rax+rdx]
;             cmp bl, [rax+rdx+1]
;             jg .swap
;             jmp .pass
;         .swap:
;             push rcx
;             mov cl, [rax+rdx+1]
;             mov [rax+rdx+1], bl
;             mov [rax+rdx], cl
;             pop rcx
;         .pass:
;             pop rbx
;             inc rdx
;             jmp .second_iter
;         .break_second:
;             pop rbx
;             inc rcx
;             jmp .first_iter
;     .break_first:
;         pop rdx
;         pop rcx
;         pop rbx
;         ret


section '.simple' executable
; input:
; rax = number
; output:
; rax = bool (number)
simple:
    push rcx
    push rdx
    mov rcx, 2
    .next_iter:
        cmp rcx, rax
        je .close
        xor rdx, rdx
        push rax
        div rcx
        pop rax
        cmp rdx, 0
        je .not_simple
        inc rcx
        jmp .next_iter
    .not_simple:
        mov rax, 0
        pop rdx
        pop rcx
        ret
    .close:
        mov rax, 1
        pop rdx
        pop rcx
        ret



; section '.goldbach' executable
; ; input:
; ; rax = number
; goldbach:
;     push rbx
;     push rcx
;     push rdx
;     mov rcx, 2  ; first
;     .first_number:
;         cmp rax, rcx
;         je .close
;         xor rdx, rdx
;         push rax
;         mov rax, rcx
;         call simple
;         mov rdx, rax
;         pop rax
;         cmp rdx, 1
;         je .second_number
        
;         inc rcx
;         jmp .first_number

;         .second_number:
;             mov rbx, rax
;             sub rbx, rcx
;             push rax
;             mov rax, rbx
;             call simple
;             mov rdx, rax
;             pop rax
;             cmp rdx, 1
;             je .close
;             inc rcx
;             jmp .first_number

;     .close:
;         ; mov rax, rcx
;         ; call print_number
;         ; mov al, ' '
;         ; call print_char
;         ; mov rax, rbx
;         ; call print_number


;         pop rdx
;         pop rcx
;         pop rbx
;         ret

