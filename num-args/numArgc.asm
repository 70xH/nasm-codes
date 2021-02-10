section .data
		NEW_LINE db 0xa
		ARGS db "argc: "
		WRONG_ARGS db "No args passed", 0xa
		len: equ $ - WRONG_ARGS

section .text
		global _start

_start:
		pop r9
		mov rax, r9
		xor r12, r12
		call print_args

		cmp r9, 1
		je wrongArgs

		jmp exit

print_args:
		xor rdx, rdx
		mov rbx, 10
		div rbx
		add rdx, 48
		add rdx, 0x0
		push rdx
		inc r12
		cmp rax, 0x0
		jne print_args

print:
		mov rax, 1
		mov rdi, 1
		mov rsi, ARGS
		mov rdx, 6
		syscall

		mov rax, 1
		mov r10, r12
		mul r12
		mov r12, 8
		mul r12
		mov rdx, rax

		mov rax, 1
		mov rdi, 1
		mov rsi, rsp
		syscall

		mov rax, 1
		mov rdi, 1
		mov rsi, NEW_LINE
		mov rdx, 1
		syscall

return:
		add rsp, 8
		dec r10
		cmp r10, 0
		jne return
		ret

wrongArgs:
		mov rax, 1
		mov rdi, 1
		mov rsi, WRONG_ARGS
		mov rdx, len
		syscall
		
exit:
		mov rax, 60
		mov rdi, 0
		syscall
