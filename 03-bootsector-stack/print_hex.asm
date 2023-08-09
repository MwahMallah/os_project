[org 0x7c00]

mov dx, 0x1F6D
call print_hex

jmp $

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

    call print_string

    ret

print_string:
    push ax
    push bx

    mov ah, 0x0e
    mov bx, HEX_OUT
    mov al, [bx]
    
    print_string_loop:
        int 0x10
        inc bx
        mov al, [bx]
        cmp al, 0
        jne print_string_loop
        
    pop bx
    pop ax
    ret 

    
HEX_OUT:
    db '0x0000', 0

times 510 - ($ - $$) db 0
dw 0xaa55