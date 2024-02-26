[bits 16]

section .text
    global _init

%include "32switch.asm"
_init:


    call setup


setup:
   call _start32
[bits 32]


main32:
    ; Your 32-bit code goes here
    mov eax, 0xB8000
    mov word [eax], '3' | ('2' << 8)   ; Store '3' in the first byte, '2' in the second byte
    add eax, 2                          ; Move to the next memory location
    mov word [eax], 'b' | ('i' << 8)   ; Store 'b' in the first byte, 'i' in the second byte
    add eax, 2                          ; Move to the next memory location
    mov word [eax], 't' | (' ' << 8)   ; Store 't' in the first byte, space in the second byte

    ; Add any necessary cleanup or further code here

    ; Return from main32
    jmp loop
loop:
    jmp $
