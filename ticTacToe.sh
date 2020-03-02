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
	if(($data>=0 && $data<=8))
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
#Logic is used  for winning condition
function winningCondition()
{
	letter=$1
	if [ "${board[0]} ${board[1]} ${board[2]}" = "$letter$letter$letter" ]
	then
		result="$win"
	elif [ "${board[3]} ${board[4]} ${board[5]}" = "$letter$letter$letter" ]
	then
		result="$win"
	elif [ "${board[6]} ${board[7]} ${board[8]}" = "$letter$letter$letter" ]
	then
		result="$win"
	elif [ "${board[0]} ${board[3]} ${board[6]}" = "$letter$letter$letter" ]
	then
		result="$win"
	elif [ "${board[1]} ${board[4]} ${board[7]}" = "$letter$letter$letter" ]
	then
		result="$win"
	elif [ "${board[2]} ${board[5]} ${board[8]}" = "$letter$letter$letter" ]
	then
		result="$win"
	elif [ "${board[6]} ${board[4]} ${board[8]}" = "$letter$letter$letter" ]
	then
		result="$win"
	elif [ "${board[2]} ${board[4]} ${board[6]}" = "$letter$letter$letter" ]
	then
		result="$win"
	else
		flag=0
		for((count=0;count<${#board[@]};count++))
		do
			if [[ "${board[$count]}"!=X || "${board[$count]}"!=O ]]
			then
				flag=1
			fi
		done
		if [ $flag==0 ]
		then
			result="draw"
		else
			result="change"
		fi
	fi
	echo $result
}
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
winningCondition $playerLetter
whoPlayFirst
letter="$(getLetter)"
playerTurn $letter
