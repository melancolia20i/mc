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
	jne	.display_usage_and_exit


.display_usage_and_exit:
	movq	$1, %rax
	movq	$2, %rdi
	leaq	.usage_msg(%rip), %rsi
	movq	.usage_len(%rip), %rdx
	syscall
	movq	$60, %rax
	movq	$0, %rdi
	syscall
