cli                   ; Disable interrupts
lgdt [gdt_descriptor] ; Load GDT

; Switch to protected mode
mov eax, cr0
or eax, 0x1
mov cr0, eax

jmp CODE_SEG:init_pm  ; Far jump to 32-bit code

[bits 32]
init_pm:
    mov ax, DATA_SEG  ; Update segment registers
    mov ds, ax
    mov ss, ax
    mov esp, 0x90000  ; Set up stack
    call kernel_main  ; Jump to kernel
    jmp $

; GDT (Global Descriptor Table)
gdt_start:
gdt_null:
    dd 0x0
    dd 0x0
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
