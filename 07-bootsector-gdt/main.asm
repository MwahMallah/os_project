[org 0x7c00]

mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string

call switch_to_pm
jmp $

%include "../05-bootsector-disk/print_string.asm" 
%include "pm-switch.asm"
%include "gdt.asm"
%include "../06-bootsector-32bit-print/print_pm.asm"

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    jmp $

MSG_REAL_MODE:
db "Started in 16-bit real mode", 0
MSG_PROT_MODE:
db "Loaded 32-bit protected mode hello", 0
; Bootsector padding
times 510 - ($ - $$) db 0
dw 0xaa55
