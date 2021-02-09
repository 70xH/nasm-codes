section .data
		NEW_LINE db 0xa

section .text
		global _start

_start:
		mov r8, 0

loop:
		mov rax, 2
		add r8, 1
		mul r8
		xor r12, r12

		call int_to_str
		cmp r8, 10
		jne loop

exit:
		mov rax, 60
		mov rdi, 0
		syscall

int_to_str:
		xor rdx, rdx
		mov rbx, 10
		div rbx
		add rdx, 48
		add rdx, 0x0
		push rdx
		inc r12
		cmp rax, 0x0
		jne int_to_str

print:
		mov r10, r12
		mov rax, 1
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
		jnz return
		ret
