#           ____           
#         ,'  , `.         
#      ,-+-,.' _ |         
#   ,-+-. ;   , ||         
#  ,--.'|'   |  || ,---.   
# |   |  ,', |  |,/     \  
# |   | /  | |--'/    / '  
# |   : |  | ,  .    ' /   
# |   : |  |/   '   ; :__  
# |   | |`-'    '   | '.'| 
# |   ;/        |   :    : 
# '---'          \   \  /  
#                 `----'   
#                          
# Aug 20 2025
# melancolia20i
# listening to: magia negra - doble porcion

.section .rodata
	.usage_msg: .string "mc: usage: mc [MODE] [MESSAGE]\n"
	.usage_len: .quad   31

.section .text

.globl _start

_start:
	popq	%rax
	cmpq	$3, %rax
	jne	.display_usage
	popq	%rax
	popq	%rax
	popq	%r8
	movzbl	(%rax), %eax
	cmpb	$'m', %al
	je	.mode_morse
	cmpb	$'t', %al
	je	.mode_text
	jmp	.display_usage
.mode_morse:
	jmp	.exit
.mode_text:
	call	Text
	jmp	.exit
.display_usage:
	movq	$1, %rax
	movq	$2, %rdi
	leaq	.usage_msg(%rip), %rsi
	movq	.usage_len(%rip), %rdx
	syscall
.exit:
	movq	$28, %rdi
	call	BufferByte
	call	BufferFlush
	movq	$60, %rax
	movq	$0, %rdi
	syscall
