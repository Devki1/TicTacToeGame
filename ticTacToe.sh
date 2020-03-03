#!/bin/bash -x
declare -a board
echo "Welcome to Tic Tac Toe Game"
board=(" " " " " " " " " " " " " " " " " ")
DOT=0
CROSS=1
USER=0
COMPUTER=1
function resultingBoard()
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
		if [[ "${board[data]}"!=X && "${board[data]}"!=O ]]
		then
			board[$data]="$playerLetter"
			resultingBoard
		else
			playerTurn $playerLetter 
		fi
	fi
}
#Logic is used  for winning condition
function checkWin()
{
	letter=$1
	if [[ "${board[0]} ${board[1]} ${board[2]}" == "$letter $letter $letter" ]]
	then
		result="win"
	elif [[ "${board[3]} ${board[4]} ${board[5]}" == "$letter $letter $letter" ]]
	then
		result="win"
	elif [[ "${board[6]} ${board[7]} ${board[8]}" == "$letter $letter $letter" ]]
	then
		result="win"
	elif [[ "${board[0]} ${board[3]} ${board[6]}" == "$letter $letter $letter" ]]
	then
		result="win"
	elif [[ "${board[1]} ${board[4]} ${board[7]}" == "$letter $letter $letter" ]]
	then
		result="win"
	elif [[ "${board[2]} ${board[5]} ${board[8]}" == "$letter $letter $letter" ]]
	then
		result="win"
	elif [[ "${board[0]} ${board[4]} ${board[8]}" == "$letter $letter $letter" ]]
	then
		result="win"
	elif [[ "${board[2]} ${board[4]} ${board[6]}" == "$letter $letter $letter" ]]
	then
		result="win"
	else
		flag=0
		for((count=0;count<${#board[@]};count++))
		do
			if [ "${board[$count]}" != "X" ] && [ "${board[$count]}" != "O" ]
			then
				flag=1
			fi
		done
		if(($flag==0))
		then
			result="draw"
		else
			result="change"
		fi
	fi
	echo $result
}
#Computer play turn
function computerTurn()
{
	computerLetter=$1

	data=$((RANDOM%9))
	if [ "${board[$data]}" != "X" ] && [ "${board[$data]}" != "O" ]
	then
		echo "Computer turn"
		board[$data]="$computerLetter"
		resultingBoard
	else
		computerTurn $computerLetter
	fi
}
#Assigned a letter
function getLetter()
{
	checkLetter=$((RANDOM%2))
	case $checkLetter in
		$DOT)
			playerLetter="O"
			computerLetter="X"
		;;
		$CROSS)
			playerLetter="X"
			computerLetter="O"
		;;
	esac
	#echo "Player: $playerLetter Computer: $computerLetter"
}
#Player chance
function whoPlayFirst()
{
	playerChance=$((RANDOM%2))
	case $playerChance in
		$USER)
			 echo "User"
		;;
		$COMPUTER)
			 echo "Computer"
		;;
	esac
}
resultingBoard
getLetter
chance="$(whoPlayFirst)"
#checkWin $playerLetter
flag=0
if [ $chance == "Computer" ]
then
	flag=1
fi
while((0==0))
do
	if (( $flag%2==0 ))
	then
		computerTurn $computerLetter
		result="$(checkWin $computerLetter)"
		if [[ $result == "win" || $result == "draw" ]]
		then
			printf "Computer $result\n"
			break
		fi
	else
		playerTurn $playerLetter
		result="$(checkWin $playerLetter)"
		if [[ $result == "win" || $result == "draw" ]]
		then
			printf "Player $result\n"
			break
		fi
	fi
	flag=$((flag+1))
done
