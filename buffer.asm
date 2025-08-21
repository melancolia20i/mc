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
	movq	%rdi, %r10
	movq	(.buf_at), %r9
.bb_main:
	cmpq	%r9, .buff_length(%rip)
	je	.bb_flush
	leaq	enAlphabet(%rip), %rbx
	movb	(%rbx, %r10), %r11b
	leaq	.buffer(%rip), %rbx
	movb	%r11b, (%rbx, %r9)
	incq	(.buf_at)
	ret
.bb_flush:
	call	BufferFlush
	jmp	.bb_main

.globl BufferWrite
BufferWrite:
	movq	%rdi, %r10
	movq	(.buf_at), %r9
.bw_loop:
	cmpq	%r9, .buff_length(%rip)
	je	.bw_flush	
	movzbl	(%r10), %edi
	cmpb	$0, %dil
	je	.bw_return
	leaq	.buffer(%rip), %rax
	movb	%dil, (%rax, %r9)
	incq	%r9
	incq	%r10
	jmp	.bw_loop
.bw_flush:
	call	BufferFlush
	jmp	.bw_loop
.bw_return:
	movq	%r9, (.buf_at)
	ret

.globl BufferFlush
BufferFlush:
	movq	$1, %rax
	movq	$1, %rdi
	leaq	.buffer(%rip), %rsi
	movq	.buf_at(%rip), %rdx
	syscall
	movq	$0, (.buf_at)
	movq	$0, %r9
	ret
