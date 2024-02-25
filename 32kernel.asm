[bits 16]

section .text
    global _init

_init:
    mov ah, 0x00
    mov al, 0x13 ; Video mode for 640x480, 256 colors
    int 0x10
    call move_down_one_line
    mov al,"<"
    call display_char
    mov al,"l"
    call display_char
    mov al,"o"
    call display_char
    mov al,"a"
    call display_char
    mov al,"d"
    call display_char
    mov al,"i"
    call display_char
    mov al,"n"
    call display_char
    mov al,"g"
    call display_char
    mov al," "
    call display_char
    mov al,"3"
    call display_char
    mov al,"2"
    call display_char
    call _start
    jmp setup

%include "32switch.asm"

setup:
   call _start
[bits 32]

main32:
    mov eax, 0xB8000      ; VGA text buffer address
    mov word [eax], 0x0F48 ; Write 'H' with white text on black background
    jmp loop

loop:
    jmp $
