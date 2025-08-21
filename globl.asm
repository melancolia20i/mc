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
# listening to: another day in paradise - phil collins

.section .rodata
	# procure not to change this definition since its length
	# is hardcoded and i refuse to create a variable for that
	# however if you really want to do it change the value of rdx
	# in 'macro.inc -> CANNOTMAP' for the new length
	cannotMap:  .string "<?>"
	.globl cannotMap

	enAlphabet: .string "abcdefghijklmnopqrstuvwxyz0123456789 /\n"
	.globl enAlphabet

	.ma: .string ".-"
	.mb: .string "-..."
	.mc: .string "-.-."
	.md: .string "-.."
	.me: .string "."
	.mf: .string "..-."
	.mg: .string "--."
	.mh: .string "...."
	.mi: .string ".."
	.mj: .string ".---"
	.mk: .string "-.-"
	.ml: .string ".-.."
	.mm: .string "--"
	.mn: .string "-."
	.mo: .string "---"
	.mp: .string ".--."
	.mq: .string "--.-"
	.mr: .string ".-."
	.ms: .string "..."
	.mt: .string "-"
	.mu: .string "..-"
	.mv: .string "...-"
	.mw: .string ".--"
	.mx: .string "-..-"
	.my: .string "-.--"
	.mz: .string "--.."
	.m0: .string "-----"
	.m1: .string ".----"
	.m2: .string "..---"
	.m3: .string "...--"
	.m4: .string "....-"
	.m5: .string "....."
	.m6: .string "-...."
	.m7: .string "--..."
	.m8: .string "---.."
	.m9: .string "----."

	morse__:
	.quad .ma
	.quad .mb
	.quad .mc
	.quad .md
	.quad .me
	.quad .mf
	.quad .mg
	.quad .mh
	.quad .mi
	.quad .mj
	.quad .mk
	.quad .ml
	.quad .mm
	.quad .mn
	.quad .mo
	.quad .mp
	.quad .mq
	.quad .mr
	.quad .ms
	.quad .mt
	.quad .mu
	.quad .mv
	.quad .mw
	.quad .mx
	.quad .my
	.quad .mz
	.quad .m0
	.quad .m1
	.quad .m2
	.quad .m3
	.quad .m4
	.quad .m5
	.quad .m6
	.quad .m7
	.quad .m8
	.quad .m9

	.globl morse__
