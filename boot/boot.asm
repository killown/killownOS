; boot.asm
[org 0x7C00]      ; BIOS loads us at this address
[bits 16]

; Set up stack
xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7C00    ; Stack grows downward from 0x7C00

; Save boot drive
mov [boot_drive], dl

; Print loading message
mov si, loading_msg
call print_string

; Load kernel from disk
mov bx, 0x1000    ; ES:BX = destination (0x1000)
mov dh, 5         ; Number of sectors to read
mov dl, [boot_drive]
call disk_load

; Switch to protected mode
cli
lgdt [gdt_descriptor]
mov eax, cr0
or eax, 0x1
mov cr0, eax
jmp CODE_SEG:init_pm

[bits 32]
init_pm:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov esp, 0x90000  ; Set up stack

    ; Jump to kernel entry point at 0x1000
    jmp 0x1000

    jmp $  ; Hang if kernel returns


; With these (add boot/ path):
%include "boot/print.asm"
%include "boot/disk.asm"

; Data
loading_msg db "Loading KillownOS...", 0
boot_drive db 0

; GDT
gdt_start:
    dq 0x0  ; Null descriptor
gdt_code:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10011010b
    db 11001111b
    db 0x0
gdt_data:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

; Boot signature
times 510-($-$$) db 0
dw 0xAA55
