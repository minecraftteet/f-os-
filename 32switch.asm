<<<<<<< HEAD
<<<<<<< HEAD
=======
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
>>>>>>> parent of 8dfd692 (the 32bit jump is still brockin)
=======
>>>>>>> parent of 0305f1f (redowing switchto32.asm)
section .text
    global _start32

_start32:
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> parent of 0305f1f (redowing switchto32.asm)
    ; Set up GDT
    mov eax, gdt_code_segment
    shl eax, 16
    or eax, 0x0000FFFF          ; Code segment with a limit of 0xFFFF (64KB)
    mov dword [gdt_code_entry], eax

    mov eax, gdt_data_segment
    shl eax, 16
    or eax, 0x0000FFFF          ; Data segment with a limit of 0xFFFF (64KB)
    mov dword [gdt_data_entry], eax

    lea eax, [gdt_pointer]
    mov ebx, eax
    add ebx, 6                   ; Move ebx to the end of the GDT
    mov word [ebx], gdt_code_segment_selector ; Set the code segment selector
    mov word [ebx + 2], gdt_data_segment_selector ; Set the data segment selector
    sub ebx, 6                   ; Move ebx back to the start of the GDT
    mov dword [gdt_pointer], ebx ; Set the GDT pointer

    ; Load GDT
    lgdt [gdt_pointer]

    ; Set PE (Protection Enable) bit in CR0 to switch to 32-bit mode
<<<<<<< HEAD
=======
    cli
    lgdt [gdtr]
>>>>>>> parent of 8dfd692 (the 32bit jump is still brockin)
=======
>>>>>>> parent of 0305f1f (redowing switchto32.asm)
    mov eax, cr0
    or eax, 0x80000001
    mov cr0, eax

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> parent of 0305f1f (redowing switchto32.asm)
    ; Flush the instruction cache
    nop

    ; Jump to the new code segment to enter 32-bit mode
    jmp gdt_code_segment_selector:bit32_mode
<<<<<<< HEAD
=======
    jmp gdt_code:main32s
=======
>>>>>>> parent of 0305f1f (redowing switchto32.asm)

>>>>>>> parent of 8dfd692 (the 32bit jump is still brockin)
[bits 32]
bit32_mode:
<<<<<<< HEAD
    ; Your 32-bit code goes here
    call main32

[bits 16]
=======
    ; Set up stack and other necessary initializations
    mov esp, stack_top

    ; Call the main 32-bit function
    call main32

    ; Infinite loop
    jmp $


>>>>>>> parent of 0305f1f (redowing switchto32.asm)
section .data
    gdt_code_segment dw 0, 0, 0, 0
    gdt_data_segment dw 0, 0, 0, 0
    gdt_code_entry dd 0
    gdt_data_entry dd 0
    gdt_pointer dw 0, 0
    gdt_code_segment_selector equ 0x08
    gdt_data_segment_selector equ 0x10

<<<<<<< HEAD

[bits 32]
section .bss
   cr0 resd 1 ; reserve space for a double-word variable (32 bits)
=======
section .bss
    stack resb 4096  ; 4KB stack space
    cr0 resd 1       ; reserve space for a double-word variable (32 bits)
>>>>>>> parent of 0305f1f (redowing switchto32.asm)
