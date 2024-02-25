section .text
    global _start32

_start32:
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
    mov eax, cr0
    or eax, 0x80000001
    mov cr0, eax

    ; Flush the instruction cache
    nop

    ; Jump to the new code segment to enter 32-bit mode
    jmp gdt_code_segment_selector:bit32_mode

[bits 32]
bit32_mode:
    ; Set up stack and other necessary initializations
    mov esp, stack_top

    ; Call the main 32-bit function
    call main32

    ; Infinite loop
    jmp $


section .data
    gdt_code_segment dw 0, 0, 0, 0
    gdt_data_segment dw 0, 0, 0, 0
    gdt_code_entry dd 0
    gdt_data_entry dd 0
    gdt_pointer dw 0, 0
    gdt_code_segment_selector equ 0x08
    gdt_data_segment_selector equ 0x10

section .bss
    stack resb 4096  ; 4KB stack space
    cr0 resd 1       ; reserve space for a double-word variable (32 bits)
