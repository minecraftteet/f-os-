[bits 16]
section .data
    gdt_start:
        dw 0                ; Null descriptor
        dw 0                ; Null descriptor
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
    cli
    lgdt [gdtr]
    mov eax, cr0
    or al, 1
    mov cr0, eax

    jmp gdt_code:main32s

[bits 32]
main32s:
    jmp main32
