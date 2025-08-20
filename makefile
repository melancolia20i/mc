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

objs  = mc.o text.o globl.o buffer.o morse.o
flags =
std   =
as    = as
exe   = mc

all: $(exe)

$(exe): $(objs)
	ld	-o $(exe) $(objs)
%.o: %.asm
	$(as)	-c $< -o $@ $(flags) $(std)
clean:
	rm	-rf $(objs) $(exe)
