[org 0x7c00]

mov bx, HELLO_WORLD
call print_string

jmp $

%include "function.asm"    

HELLO_WORLD:
    db "Hello world", 0

times 510 - ($ - $$) db 0
dw 0xaa55