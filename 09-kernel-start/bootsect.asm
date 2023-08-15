[org 0x7c00]
KERNEL_OFFSET equ 0x1000; memory offset to which we will load kernel

    mov [BOOT_DRIVE], dl ; BIOS stores boot drive in DL

    mov bp, 0x9000 ; Set-up the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE ; Print string 
    call print_string     ; that we are starting
    call print_nl

    call load_kernel; Loading kernel

    call switch_to_pm;  Switch to protected mode

    jmp $    ; will not be executed


%include "../16bit/print_string.asm"
%include "../16bit/pm-switch.asm"
%include "../16bit/disk.asm"
%include "../16bit/print_pm.asm"
%include "../16bit/gdt.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print_string
    call print_nl
    
    mov bx, KERNEL_OFFSET; calling disk load to store
    mov dh, 15           ; 15 sectors
    mov dl, [BOOT_DRIVE] ; to KERNEL_OFFSET

    call disk_load
    ret

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE ; Use of 32-bit protected mode print to show that we are in protected mode
    call print_string_pm

    call KERNEL_OFFSET
    jmp $

BOOT_DRIVE db 0
MSG_REAL_MODE db "Starting 16-bit real mode.", 0
MSG_LOAD_KERNEL db "Loading kernel into memory.", 0
MSG_PROT_MODE db "Successfully landed in 32-bit Protected Mode.", 0

times 510 - ($ - $$) db 0
dw 0xaa55