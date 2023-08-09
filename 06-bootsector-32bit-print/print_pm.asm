[bits 32]
;define constants
VIDEO_MEMORY equ 0xb8780
GREEN_TEXT_COLOR equ 0x04
RED_TEXT_COLOR equ 0x02

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY
    mov ecx, 0

print_string_pm_loop:
    mov al, [ebx]        ; store char from string in lower byte of ax
    cmp ecx, 0
    je set_green_color
    mov ecx, 0
    mov ah, RED_TEXT_COLOR
return_from_setting_color:
    cmp al, 0            ; check if it is the end of the stirng
    je print_string_pm_done

    mov [edx], ax

    add ebx, 1           ; inc to next char
    add edx, 2           ; every char is 2 bytes in video memory
    jmp print_string_pm_loop

set_green_color:
    mov ah, GREEN_TEXT_COLOR
    inc ecx
    jmp return_from_setting_color

print_string_pm_done:
    popa
    ret
