[bits 16]

section .data
    buffer dw 256

section .text
    global _main

_main:
    ; Set video mode function
    mov ah, 0x00
    mov al, 0x13 ; Video mode for 640x480, 256 colors
    int 0x10
    mov al, buffer
    call display_char
    ;mov dx, 0
    ;mov cx, 0

main_loop:
    ; Read a key from the keyboard
    call read_key

    ;mov ax, 0x0c07
    ;int 0x10
    ;inc dx
    ;inc cx
    ; Display the pressed key
    call display_char

    ; Check if the 'Enter' key is pressed
    cmp al, 13     ; ASCII code for 'Enter'
    jne continue_loop  ; Jump to continue the loop if not 'Enter' key

    ; Move down one line
    call move_down_one_line

continue_loop:
    ; Check if the 'ESC' key is pressed to exit the loop
    cmp al, 27     ; ASCII code for 'ESC'
    je exit_loop
    cmp al, 08
    je backspace

    ; Continue the loop
    jmp main_loop

exit_loop:
    int 0x19
read_key:
    ; Read a key from the keyboard
    mov ah, 0
    int 0x16
    ret

display_char:
    ; Display the character in AL to the screen
    mov ah, 0x0E    ; BIOS teletype function
    mov bh, 0       ; Page number (0 for video modes)
    mov bl, 0x2    ; Attribute (white on black)
    int 0x10
    ret

move_down_one_line:
    ; Get current cursor position
    mov ah, 0x03    ; Get cursor position function
    int 0x10
    ; Increment the row
    inc dh
    ; Set the new cursor position
    mov ah, 0x02    ; Set cursor position function
    int 0x10
    mov al, ">"
    call display_char
    ret
backspace:
    mov al,0
    ;call display_char
    mov al, 08
    ;call display_char
    jmp main_loop
