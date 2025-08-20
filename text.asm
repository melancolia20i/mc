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
# listening to: bouge - princesse

.section .text

.globl Text

Text:
	xorq	%rax, %rax
.text_loop:	
	movzbl	(%r8), %edi
	cmpb	$0, %dil
	je	.text_return
	call	.Morseable
	cmpq	$0, %rax
	jz	.text_unmappable
	cmpb	$'a', %dil
	jge	.text_fit_into_0_25
	cmpb	$'A', %dil
	jge	.text_turn_into_lower
	subb	$'0', %dil
	addb	$26, %dil
	jmp	.text_map_ready
.text_turn_into_lower:
	addb	$32, %dil
.text_fit_into_0_25:
	subb	$'a', %dil
.text_map_ready:
	leaq	morse__(%rip), %rax
	movq	(%rax, %rdi, 8), %rdi
	call	BufferWrite	
	jmp	.text_inc
.text_unmappable:
	cmpb	$' ', %dil
	je	.text_map_to_space
	leaq	cannotMap(%rip), %rdi
	call	BufferWrite
	jmp	.text_inc
.text_map_to_space:
	movq	$27, %rdi
	call	BufferByte
.text_inc:
	movq	$26, %rdi
	call	BufferByte
	incq	%r8
	jmp	.text_loop
.text_return:
	ret

.Morseable:
	cmpb	$'0', %dil
	jl	.morseable_no
	cmpb	$'9', %dil
	jle	.morseable_yes
	cmpb	$'A', %dil
	jl	.morseable_no
	cmpb	$'Z', %dil
	jle	.morseable_yes
	cmpb	$'a', %dil
	jl	.morseable_no
	cmpb	$'z', %dil
	jle	.morseable_yes
.morseable_no:
	movq	$0, %rax
	ret
.morseable_yes:
	movq	$1, %rax
	ret
