[bits 16]
switch_to_pm:
    cli ; 1. disable interrupts
    lgdt [gdt_descriptor] ; use instruction lgdt to load gdt to gdt register

    mov eax, cr0   ; we need to set cr0 first bit to 1 to enter
    or eax, 0x1    ; 32bit protected mode
    mov cr0, eax

    jmp CODE_SEG:init_pm   ; making a far jump to 32-bit code


[bits 32]

init_pm:

    mov ax, DATA_SEG   ; set new values for segments
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax  

    mov ebp, 0x90000  ; update stack position
    mov esp, ebp

    call BEGIN_PM     ; calling defined 32bit routine