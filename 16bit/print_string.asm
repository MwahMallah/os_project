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


print_nl:
    push ax
    mov ah, 0x0e
    mov al, 0x0a
    int 0x10
    mov al, 0x0d
    int 0x10
    pop ax
    ret


print_hex:
    print_hex:
    push ax
    push bx
    push cx
    xor ax, ax
    mov bx, HEX_OUT + 5
    mov cx, 4

    print_hex_loop:
        mov ax, 0x000F
        and ax, dx
        add al, '0'
        cmp al, '9'
        jle print_hex_num
        add al, 7
    print_hex_num:
        mov [bx], al
        dec bx
        shr dx, 4
        dec cx
        cmp cx, 0
        jne print_hex_loop

    pop cx
    pop bx
    pop ax

    push bx
    mov bx, HEX_OUT
    call print_string
    pop bx
    ret

HEX_OUT:
    db "0x0000", 0