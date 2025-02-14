; adapted from https://en.wikibooks.org/wiki/X86_Assembly/Bootloaders
; and https://blog.ghaiklor.com/2017/10/21/how-to-implement-your-own-hello-world-boot-loader
    BITS 16
    org 7C00h       ; where code gets loaded by the bios
    jmp short main  ; jump over the data

msg db "Hello World! ", 0

main:
    cli             ; disable interrupts
    xor ax, ax      ; zero out out all registers
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; clear the screen
    mov ax, 0x03
    int 0x10

    mov cx, 0xFFFF
delay_loop:         ; delay to ensure hardware is initialized
    loop delay_loop ; this is necessary for running on real hardware

    ; set the segment up to write to VGA video memory
    mov ax, 0xb800
    mov es, ax

    ; make the color white on a black background
    mov ah, 0x0F

    ; si points to msg now
    mov si, msg

    ; we use bx to keep track of where we are in video memory
    mov bx, 0

loop:
    lodsb           ; loads si into al and increments si
    or al, al       ; check if we hit the end of the string
    jz nums         ; print the numbers if we're at the end
    mov WORD [es:bx], ax    ; write the character to video memory
    add bx, 2       ; go to the next position in video memory
    jmp loop

nums:
    ; do the addition
    mov	ax, 6    	; put 6 into ax
    add	ax, 9		; add 9 to 6 into ax

    ; to print the individual characters, we need to divide
    ; to get the tens place and the ones place.
    mov dx, 0		; clear dividend
    mov cx, 10		; divide ax by 10
    div cx		; ax = 1, dx = 5
    add ax, 0x30	; add ascii value of '0' to get the ascii value of the number
    add dx, 0x30

    mov ah, 0x0F    ; make the characters white
    mov dh, 0x0F

    mov WORD [es:bx], ax    ; write the character '1' to video memory
    add bx, 2               ; go to the next position in video memory
    mov WORD [es:bx], dx    ; write the character '5' to video memory

    hlt             ; we're done, we can halt

; pad out the rest of the boot sector and add the magic number
times 510 - ($ - $$) db 0
dw 0xAA55
