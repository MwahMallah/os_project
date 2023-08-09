[org 0x7c00]

mov ah, 0x0e ; setting teletype mode
mov bx, string ; cl is pointing to offset of the string

loop:
    mov al, [bx]
    cmp al, 0
    je end
    int 0x10
    inc bx
    jmp loop

end:

string:
    db "Hello world", 0

times 510 - ($ - $$) db 0
dw 0xaa55