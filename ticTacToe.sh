#!/bin/bash -x
declare -a board
echo "Welcome to Tic Tac Toe Game"
board=(" " " " " " " " " " " " " " " " " ")
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
