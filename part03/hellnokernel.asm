; adapted from https://tldp.org/HOWTO/Assembly-HOWTO/hello.html

        SECTION .data		; Data section, initialized variables

msg:    db "Hello World! ", 0     ; The message
len:	equ $ - msg
nl:		db 10, 0

        SECTION .text           ; Code section.
        global main

main:				; the program label for the entry point

	mov edx, len	; third argument: message length
	mov ecx, msg	; second argument: pointer to message to write
	mov ebx, 1		; first argument: file handle (stdout)
	mov eax, 4		; system call number (sys_write)
	int 0x80

	; do the addition
	mov	eax, 6  	; put 6 into eax
	add	eax, 9		; add 9 to 6 into eax

	; to print the individual characters, we need to divide
	; to get the tens place and the ones place.
	mov edx, 0		; clear dividend
	mov ecx, 10		; divide eax by 10
	div ecx			; eax = 1, edx = 5
	add eax, 0x30	; add ascii value of '0' to get the ascii value of the number
	add edx, 0x30
	push edx		; push them onto the stack to get ready for sys_write
	push eax

	; print the number 1
	mov edx, 1
	mov ecx, esp
	mov ebx, 1
	mov eax, 4
	int 0x80

	; print the number 5
	pop ecx
	mov edx, 1
	mov ecx, esp
	mov ebx, 1
	mov eax, 4
	int 0x80

	; print a new line
	mov edx, 1
	mov ecx, nl
	mov ebx, 1
	mov eax, 4
	int 0x80

	add esp, 4		; clean the stack

	mov	eax, 0		; normal, no error, return value
	ret				; return
