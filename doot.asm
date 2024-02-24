[bits 16]
section .text
    global _start

_start:
    ; Set up the segment registers
    mov ax, 0x07C0
    add ax, 288
    mov ss, ax
    mov sp, 4096

    ; Load the bootloader to memory
    mov ax, 0x07C0
    mov ds, ax

    ; Call the function to load the kernel
    call load_kernel

    ; Jump to the loaded kernel
    jmp 0x0000:0x2000

load_kernel:
    ; Load kernel to memory (assumes kernel is in second sector)
    mov ah, 0x02       ; BIOS read sector function
    mov al, 1          ; Number of sectors to read
    mov ch, 0          ; Cylinder number
    mov cl, 2          ; Sector number
    mov dh, 0          ; Head number
    mov dl, 0x80       ; Drive number (0x80 for the first hard drive)

    mov bx, 0x2000     ; Destination address in memory
    int 0x13            ; Call BIOS interrupt for disk I/O

    ret

times 510 - ($-$$) db 0
dw 0xAA55
