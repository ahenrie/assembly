; printString.asm
; Generic function to print null-terminated string to screen
; ----------------
; PARAMETERS
; rdi - Address of string to print
; RETURN VALUE
; rax - count of characters printed
; ERROR CHECKING
; None

SYS_write		equ		1
STDOUT			equ		1

GLOBAL printString
printString:
		mov rsi, rdi	; set base to address of string
		mov rdx, 0		; set counter to 0
count:
		mov al, byte [rsi+rdx]		; get a character
		cmp al, 0					; is it zero?
		je done						; if so, done
		inc rdx
		jmp count
done:
		cmp rdx, 0
		je return
		mov rax, SYS_write
		mov rdi, STDOUT	
								; already set: rsi - address, rdx - count
		syscall
return:
		mov rax, rdx
		ret
