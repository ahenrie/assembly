;Final MAIN
;----------------------------------------------------STEPS-----------------------------------------------------------------------------
;	1. Greet the user with external function.
;	2. Ask if they would like to know their lucky number.
;	3a. If yes, ask for the following: first name, last name, DOB, color. (only do anything with first_name and choice)
;	3b. If no, print noPass then terminate
;	4. Display new lucky number then exit. 
;-----------------------------------------------------------------------------------------------------------------------------------------

;--------------------------------------------------Data Dec-------------------------------------------------------------------------
section .data
LF 							equ 							10 					; line feed
NULL 						equ 							0 						; end of string
TRUE 						equ 							1
FALSE 						equ 							0
EXIT_SUCCESS 			equ 							0 						; success code
STDIN 						equ 							0 						; standard input
SYS_read					equ							0						;read
SYS_write					equ							1						;write
STDOUT 					equ 							1 						; standard output
STDERR 					equ 							2 						; standard error
SYS_exit 					equ 							60 					; terminate

;----------Variables---------
welcome 					db							"Welcome to Lucky's Number Generator!", LF, NULL
prompt1					db							"Would you like to know your lucky number [Y or N]: ", NULL
noPass						db							"Sheesh, then stop typing ./final.", LF, NULL
Q1							db							"What is your name: ", NULL
Q2							db							"What is your last name: ", NULL
Q3							db							"What year were you born: ", NULL
Q4							db							"What is your favorite color: ", NULL
final							db							", here is your final lucky number: ", NULL
deadspace				db							LF
lastSaying					db							"If the universe says nothing, try again.", LF, NULL
goodbye_message		db							"You don't seem all that bright. Lucky number: 0", LF, NULL

;----------Reserved---------
section .bss
choice						resb						1
first_name					resb						50
last_name					resb						50
dob							resb						50
color							resb						50

;----------Extern Links-----
extern printString																;import printString function
extern inputString																;import inputString function
extern check_choice
extern generate_number
;--------------------------------------------------Code Sec---------------------------------------------------------------------------

section .text

global _start
_start:
		mov rdi, welcome
		call printString															; welcome user
		mov rdi, prompt1														; ask to create password
		call printString
		mov rdi, choice
		call inputString
		mov rdi, choice
		call check_choice														; call check_choice function to validate user's choice
		mov r10, rdi
		cmp byte [r10], "Y"
		je ifyes
		cmp byte [r10], "N"
		je ifno
		jmp wrong_input
		
																						;Display and mov needed strings using printString
																						;Take first_name and choice using inputString
ifyes:
		mov rdi, Q1
		call printString
		mov rdi, first_name
		call inputString
		mov rdi, Q2
		call printString
		mov rdi, last_name
		call inputString
		mov rdi, Q3
		call printString
		mov rdi, dob
		call inputString
		mov rdi, Q4
		call printString
		mov rdi, color
		call inputString
		mov rdi, first_name
		call printString
		mov rdi, final
		call printString
																						;Get lucky number then print to console with other strings.
		call generate_number
		mov rdi, rax
		call printString
		mov rdi, deadspace
		call printString
		jmp last

																						;If choice = "N", print NoPass then exit
ifno:
		mov rdi, noPass
		call printString
		jmp last

wrong_input:
		mov rdi, goodbye_message
		call printString

last:
		mov			rax, SYS_exit												;Call code for exit
		mov			rdi, EXIT_SUCCESS										;Exit program with success
		syscall
