print_string:
    push bx
    push ax
    mov ah, 0x0e
    mov al, [bx]

loop:
    int 0x10
    inc bx
    mov al, [bx]
    cmp al, 0
    jne loop 
    
    pop ax
    pop bx
    ret
