mov ah, 0x0e ; tty mode

mov bp, 0x8000 ; address of boot sector is 0x7c00, won't be overwritten
mov sp, bp; sp points to bp at the start

push 'A'
push 'B'
push 'C'

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

pop bx 
mov al, bl
int 0x10

mov al, [0x8000]
int 0x10

times 510 - ($ - $$) db 0
dw 0xaa55