[bits 16]
section .data
    gdt_start:
        dd 0          ; Null descriptor
        dd 0

        dw 0xFFFF     ; Code descriptor
        dw 0
        db 0
        db 0b10011010 ; Type flags (code, readable, non-conforming, not accessed)
        db 11001111   ; Granularity flags (4K pages, 32-bit protected mode)
        db 0
    gdt_code:
        dw 0FFFFh           ; Limit (low)
        dw 0                ; Base (low)
        db 0                ; Base (mid)
        db 10011010b        ; Type flags (code, readable, non-conforming, not accessed)
        db 11001111b        ; Granularity flags (4K pages, 32-bit protected mode)
        db 0                ; Base (high)
    gdt_data:
        dw 0FFFFh           ; Limit (low)
        dw 0                ; Base (low)
        db 0                ; Base (mid)
        db 10010010b        ; Type flags (data, writable, expand-down, not accessed)
        db 11001111b        ; Granularity flags (4K pages, 32-bit protected mode)
        db 0                ; Base (high)
    gdt_end:
    gdtr:
        dw gdt_end - gdt_start - 1  ; GDT limit
        dd gdt_start               ; GDT base

section .text
    global _start32

_start32:
    cli              ; Disable interrupts
    in al, 0x92      ; Read the keyboard controller output port
    or al, 2         ; Set bit 1 (A20) in the output port
    out 0x92, al     ; Write the modified value back to the output port

    slc
    lgdt [gdtr]
    mov eax, cr0
    or al, 1
    mov cr0, eax
    ; Use the correct selector for the jump (not a far jump)
    jmp gdt_code:main32s
[bits 32]
main32s:
    jmp main32
