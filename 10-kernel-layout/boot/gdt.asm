gdt_start:
    dd 0x0 ; GDT starts
    dd 0x0 ; with a null 8 byte

;GDT for code segment. base = 0x00000000, length = 64KB = 0xffffff
;flags are set 
gdt_code:
    dw 0xffff    ; Limit (bits 0-15)
    dw 0x0       ; Base (bits 0-15)
    db 0x0       ; Base (bits 16-23)
    db 10011010b ; flags
    db 11001111b ; flags, Limit (bits 16-19)
    db 0x0       ; Base (bits 24-31)

gdt_data:
    dw 0xffff    ; Limit
    dw 0x0       ; Base
    db 0x0       ; Base
    db 10010010b ; flags
    db 11001111b ; flags + limit
    db 0x0       ; base

gdt_end:

;gdt descriptor = gdt_size(16bits) + gdt_address(32_bits)
gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; Size of GDT, that is less one that true size
    dd gdt_start


CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start