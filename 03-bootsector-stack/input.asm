[org 0x7c00]

mov ah, 0x0e
mov bx, enter_string

loop:
    mov al, [bx]
    cmp al, 0
    je end
    int 0x10
    inc bx
    jmp loop

end:

mov ah, 0
int 0x16
mov ah, 0x0e
int 0x10

jmp end

enter_string:
    db "Enter string: ", 0

times 510 - ($ - $$) db 0
dw 0xaa55