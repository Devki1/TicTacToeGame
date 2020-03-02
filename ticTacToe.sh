#!/bin/bash -x
declare -a board
echo "Welcome to Tic Tac Toe Game"
board=(" " " " " " " " " " " " " " " " " ")
Dot=0
cross=1
User=0
Computer=1
function resultingboard()
{
	echo "${board[0]} | ${board[1]} | ${board[2]}"
	echo "----------"
	echo "${board[3]} | ${board[4]} | ${board[5]}"
	echo "----------"
	echo "${board[6]} | ${board[7]} | ${board[8]}"
}
#Choose a valid cell
function playerTurn()
{
	playerLetter=$1
	echo "Enter a valid cell data from 0 to 8:" data
	read data
	if(($data>0 && $data<8))
	then
		if [[ "${board[data]}"!=X || "${board[data]}"!=O ]]
		then
			board[$data]="$playerLetter"
		else
			valid $playerLetter 
		fi
	fi
resultingboard
}
#This function is used to get a letter O or X
function getLetter()
{
	checkLetter=$((RANDOM%2))
	case $checkLetter in
		$Dot)
			playerLetter="O"
			;;
		$cross)
			playerLetter="X"
			;;
	esac
	echo $playerLetter
}
#This function is used to check is who play first
function whoPlayFirst()
{
	playerChance=$((RANDOM%2))
	case $playerChance in
		$User)
			echo "User chance play first: "
			;;
		$Computer)
			echo "computer chance play first:"
			;;
	esac
}
letter="$(getLetter)"
#call the function
whoPlayFirst
playerTurn $letter

