;generate_numbers.asm
;---------------------PARAMETERS/OVERVIEW---------------------
;takes no parameter other than length and digits
;stores number to rax which will be moved to rdi to be used in printString

section .data
	digits					db 									'123456789', 0				;digits to generate number
	digits_len				equ									16									;max length of digits (keeping it 16)

section .bss
	number 				resb									16

section .text
	global generate_number

generate_number:
	mov eax, 44																						;44 is my favorite number, so we start there
	mov [rsp-4], eax																					;store on the stack
	xor ecx, ecx																							;set ecx to 0
	mov ebx, 1236718945																		;random constant to be initlialized with

																												; generate number
	mov esi, number
	mov edi, esi
	mov ecx, 16

random_loop:
	add [rsp-4], ebx
	rdrand edx																							;rdrand is an instruction I had to look up
	and edx, 10																							;and with 10 to get 1-9
	mov dl, [digits + edx]																			;use as index
	mov [esi], dl																						;store
	inc esi																									;+1
	loop random_loop																				;loop again

	mov byte [edi+16], 0																			;ensure it is null-terminated
	mov rax, number																				;store number into rax
	ret
