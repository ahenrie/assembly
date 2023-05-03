; inputString.asm
NL			equ			10
STDIN		equ			0
SYS_read	equ			0

SECTION .data
STRLEN		equ			256

SECTION .bss
chr			resb		1

SECTION .text
GLOBAL inputString

; read characters one at a time
inputString:
	push rbx
	push r12
	mov	rbx, rdi
	mov r12, 0
readCharacters:
	mov rax, SYS_read		; system code
	mov rdi, STDIN			; keyboard
	mov rsi, chr			; single character buffer
	mov rdx, 1				; read one character
	syscall
	
	mov al, byte [chr]		; retrieve character
	cmp al, NL				; compare to newline
	je readDone
	inc r12					; increment counter
	cmp r12, STRLEN			; compare to buffer length
	jae readCharacters		; stop placing characters in buffer
	mov byte [rbx], al		; store character in buffer
	inc rbx					; next spot in buffer
	jmp readCharacters
readDone:
	mov byte [rbx], 0
	pop r12
	pop rbx
	ret
