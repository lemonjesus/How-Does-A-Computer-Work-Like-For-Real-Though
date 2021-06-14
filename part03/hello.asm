; adapted from https://www.csee.umbc.edu/portal/help/nasm/sample.shtml

; Declare some external functions
;
        extern	printf		; the C function, to be called

        SECTION .data

fmt:    db "Hello World! %d", 10, 0     ; The printf format, "\n",'0'

        SECTION .text           ; Code section.
        global main		; the standard gcc entry point

main:				; the program label for the entry point
        push    ebp		; set up stack frame
        mov     ebp,esp

	mov	eax, 6  	; put 6 into EAX
	add	eax, 9		; add 9 to 6 into EAX
	push	eax		; push it onto the stack as the second argument to printf
        push    dword fmt	; push the address of the format string as the first argument to printf
        call    printf		; Call printf

        add     esp, 8		; clean up the stack
        mov     esp, ebp
        pop     ebp

	mov	eax,0		; normal, no error, return value
	ret			; return
