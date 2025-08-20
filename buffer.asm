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
# listening to: b4 (summer tape III) - binary digit

.section .rodata
	.buff_length: .quad 2048

.section .bss
	.buffer: .zero 2048
	.buf_at: .zero 8

.section .text

.globl BufferByte
BufferByte:

.globl BufferWrite
BufferWrite:
	movq	(.buf_at), %rcx
	xorq	%rbx, %rbx
.bw_loop:
	movq	.buff_length(%rip), %rax
	cmpq	%rcx, %rax
	je	.bw_flush
	movzbl	(%rdi), %eax
	cmpb	$0, %al
	je	.bw_return
	leaq	.buffer(%rip), %rbx
	movb	%al, (%rbx, %rcx)
	incq	%rcx
	incq	%rdi
	jmp	.bw_loop
.bw_return:
	movq	%rcx, (.buf_at)
	ret
.bw_flush:
	call	BufferFlush
	jmp	.bw_loop

.globl BufferFlush
BufferFlush:
	movq	$1, %rax
	movq	$1, %rdi
	leaq	.buffer(%rip), %rsi
	movq	.buf_at(%rip), %rdx
	syscall
	movq	$0, (.buf_at)
	ret
