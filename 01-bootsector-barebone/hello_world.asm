mov ah, 0x0e

mov al, 'H'
int 0x10

mov al, 'e'
int 0x10

mov al, 'l'
int 0x10

mov al, 'l'
int 0x10

mov al, 'o'
int 0x10

mov al, 32
int 0x10

mov al, 'W' 
int 0x10

mov al, 'o'
int 0x10

mov al, 'r'
int 0x10

mov al, 'l'
int 0x10

mov al, 'd'
int 0x10

loop:
    jmp loop

times 510-($-$$) db 0
dw 0xaa55