[bits 16]

section .text
    global _init

_init:

    mov ah, 0x00
    mov al, 0x13 ; Video mode for 640x480, 256 colors
    int 0x10

    call setup

%include "32switch.asm"

setup:
   call _start32
[bits 32]

main32:
<<<<<<< HEAD
    mov eax, 0xB8000      ; VGA text buffer address
    mov word [eax], "3" ; Write 'H' with white text on black background
    mov word [eax], "2" ; Write 'H' with white text on black background
    mov word [eax], "b" ; Write 'H' with white text on black background
    mov word [eax], "i" ; Write 'H' with white text on black background
    mov word [eax], "t" ; Write 'H' with white text on black background
    jmp loop

loop:
    jmp $
=======
    ; Your 32-bit code goes here
    mov eax, 0xB8000
    mov word [eax], '3' | ('2' << 8)   ; Store '3' in the first byte, '2' in the second byte
    add eax, 2                          ; Move to the next memory location
    mov word [eax], 'b' | ('i' << 8)   ; Store 'b' in the first byte, 'i' in the second byte
    add eax, 2                          ; Move to the next memory location
    mov word [eax], 't' | (' ' << 8)   ; Store 't' in the first byte, space in the second byte

    ; Add any necessary cleanup or further code here

    ; Return from main32
    ret

%include "32switch.asm"
>>>>>>> parent of 0305f1f (redowing switchto32.asm)
