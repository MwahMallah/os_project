mov ah, 0x0e

mov cl, 97
mov bl, 66

loop:
    mov al, cl
    int 0x10

    mov al, bl
    int 0x10

    add cl, 2
    add bl, 2

    cmp bl, 'Z'
    jle loop 

jmp $

times 510-($-$$) db 0
dw 0xaa55