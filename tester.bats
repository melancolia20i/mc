#! /usr/bin/evv bats
#
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
# Aug 21 2025
# melancolia20i
# listening to: no music

@test "from text to morse (1)" {
	result="$(./mc t 'there is something about you')"
	[ "$result" = "- .... . .-. . / .. ... / ... --- -- . - .... .. -. --. / .- -... --- ..- - / -.-- --- ..- " ]
}

@test "from text to morse (2)" {
	result="$(./mc t 'the quick brown fox jumps over the lazy dog')"
	[ "$result" = "- .... . / --.- ..- .. -.-. -.- / -... .-. --- .-- -. / ..-. --- -..- / .--- ..- -- .--. ... / --- ...- . .-. / - .... . / .-.. .- --.. -.-- / -.. --- --. " ]
}

@test "from text to morse (3)" {
	result="$(./mc t '0 1 2 3 4 5 6 7 8 9')"
	[ "$result" = "----- / .---- / ..--- / ...-- / ....- / ..... / -.... / --... / ---.. / ----. " ]
}

@test "from morse to text (1)" {
	result="$(./mc m '- .... . .-. . / .. ... / ... --- -- . - .... .. -. --. / .- -... --- ..- - / -.-- --- ..- ')"
	[ "$result" =  "there is something about you" ]
}

@test "from morse to text (2)" {
	result="$(./mc m '- .... . .-. . / .. ... / ... --- -- . - .... .. -. --. / .- -... --- ..- - / -.-- --- ..- ')"
	[ "$result" = "there is something about you" ]
}

@test "from morse to text (3)" {
	result="$(./mc m '----- / .---- / ..--- / ...-- / ....- / ..... / -.... / --... / ---.. / ----. ')"
	[ "$result" = "0 1 2 3 4 5 6 7 8 9" ]
}

@test "empty morse sequence" {
	result="$(./mc m '')"
	[ "$result" = "" ]
}

@test "empty text sequence" {
	result="$(./mc t '')"
	[ "$result" = "" ]
}
