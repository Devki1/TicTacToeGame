#!/bin/bash -x
declare -a board
echo "Welcome to Tic Tac Toe Game"
board=(" " " " " " " " " " " " " " " " " ")
O="0"
X="X"
function resultingboard()
{
	echo "${board[0]} | ${board[1]} | ${board[2]}"
	echo "----------"
	echo "${board[3]} | ${board[4]} | ${board[5]}"
	echo "----------"
	echo "${board[6]} | ${board[7]} | ${board[8]}"
}
#Call the function 
resultingboard
checkLetter=$((RANDOM%2))
case $checkLetter in
		0)
			echo "you assigned:"$O
			;;
		1)
			echo "you assigned:"$X
			;;
esac
