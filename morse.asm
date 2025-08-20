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
# listening to: trois neuf trois - 39bermuda

.section .bss
	# stores the current token as it is given; its length
	# is 6 since the max length for a morse code is 5 + \0
	.thistoken: .zero 6

.section .text

.globl Morse

Morse:
	xorq	%rax, %rax
	# r15: pointer to the nth position in 'thistoken'
	# r14: r15's length
	leaq	.thistoken(%rip), %r15
	movq	$0, %r14
.morse_loop:
	movzbl	(%r8), %edi
	cmpb	$0, %dil
	je	.morse_return
	call	.Collectable
	cmpq	$0, %rax
	je	.morse_uncoll

	movb	%dil, (%r15)
	incq	%r15
	incq	%r14
	jmp	.morse_inc
.morse_uncoll:
	cmpb	$' ', %dil
	je	.morse_gotoken
	cmpb	$'/', %dil
	je	.morse_space
.morse_gotoken:
	movq	$60, %rax
	movq	$60, %rdi
	syscall

.morse_space:
	movq	$26, %rdi
	call	BufferByte
.morse_inc:
	incq	%r8

.morse_return:
	ret

.Collectable:
	movq	$1, %rax
	cmpb	$'-', %dil
	je	.coll_ret
	cmpb	$'.', %dil
	je	.coll_ret
	cmpb	$'/', %dil
	je	.coll_ret
	movq	$0, %rax
.coll_ret:
	ret
