mov ah, 0x0e
mov al, 65
mov cl, 90

print_alphabet_upper:
    int 0x10
    inc al
    cmp al, cl
    jle print_alphabet_upper

mov al, ' '
int 0x10

mov cl, 122
mov al, 97

print_alphabet_lower:
    int 0x10
    inc al
    cmp al, cl
    jle print_alphabet_lower

loop:
    jmp loop

times 510 - ($-$$) db 0
dw 0xaa55