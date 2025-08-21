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
	.thistoken: .zero 8

	# this flag is set to 1 when a '/' is found wihtout previous ' '
	# such as : ../.-
	#             ` print '..' translated and then the actual space ' '
	.spaceafter: .zero 1

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
	jne	.morse_inc
	movb	$1, (.spaceafter)
.morse_gotoken:	
	cmpq	$0, %r14
	je	.morse_gotoken_check_flag
	leaq	morse__(%rip), %r9
	movq	$0, %r10
.morse_gotoken_loop:
	cmpq	$36, %r10
	je	.morse_gotoken_unk
	movq	(%r9, %r10, 8), %rsi
	call	.Strcmp
	cmpq	$1, %rax
	je	.morse_gotoken_ok
	incq	%r10
	jmp	.morse_gotoken_loop
.morse_gotoken_ok:
	movq	%r10, %rdi
	call	BufferByte
	jmp	.morse_gotoken_check_flag
.morse_gotoken_unk:
	leaq	cannotMap(%rip), %rdi
	call	BufferWrite
.morse_gotoken_check_flag:
	cmpb	$1, (.spaceafter)
	jne	.morse_gotoken_clean
	movq	$26, %rdi
	call	BufferByte
	movb	$0, (.spaceafter)
.morse_gotoken_clean:
	movq	$0, %r14
	movq	$0, (.thistoken)
	leaq	.thistoken(%rip), %r15

# TODO: check flags
# TODO: make sure r14 does not go beyond 5

.morse_inc:
	incq	%r8
	jmp	.morse_loop
.morse_return:
	ret
.Collectable:
	movq	$1, %rax
	cmpb	$'-', %dil
	je	.coll_ret
	cmpb	$'.', %dil
	je	.coll_ret
	movq	$0, %rax
.coll_ret:
	ret


.Strcmp:	
	leaq	.thistoken(%rip), %rdi
.strcmp_loop:
	movzbl	(%rdi), %eax
	movzbl	(%rsi), %ebx
	cmpb	%al, %bl
	jne	.strcmp_pas_meme	
	cmpb	$0, %al
	je	.strcmp_equal
	incq	%rdi
	incq	%rsi
	jmp	.strcmp_loop
.strcmp_equal:
	movq	$1, %rax
	jmp	.strcmp_return
.strcmp_pas_meme:
	movq	$0, %rax
.strcmp_return:
	ret
