#!/bin/bash -x
#Constant
DOT=0
CROSS=1
PLAYER=0
COMPUTER=1
IS_EMPTY=" "
#Variable
computerLetter=""
playerLetter=""
declare -a board
board=(" " " " " " " " " " " " " " " " " ")
#Diaplay the tic tac toe board
function displayBoard()
{
	echo "Welcome to Tic Tac Toe Game"
	echo "			${board[0]} | ${board[1]} | ${board[2]}"
	echo "			----------"
	echo "			${board[3]} | ${board[4]} | ${board[5]}"
	echo "			----------"
	echo "			${board[6]} | ${board[7]} | ${board[8]}"
}
#Choose a valid cell
function playerTurn()
{
	playerLetter=$1
	printf "Enter a valid cell data from 0 to 8:" data
	read data
	if(($data>=0 && $data<=8))
	then
		if [[ "${board[data]}"!=X && "${board[data]}"!=O ]]
		then
			board[$data]="$playerLetter"
			displayBoard
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
	 elif [[ "${board[0]} ${board[3]} ${board[6]}" == "$letter $letter $letter" ]]
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
		for((index=0;index<${#board[@]};index++))
		do
			if [ "${board[$index]}" != "X" ] && [ "${board[$index]}" != "O" ]
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
}
#Player chance
function whoPlayFirst()
{
	playerChance=$((RANDOM%2))
	case $playerChance in
		$PLAYER)
			echo "playerChance"
			;;
		$COMPUTER)
			echo "computerChance"
			;;
	esac
}
#Checking if computer can win next move
function check_Block_WiningMove()
{
	local letter=$1
	index=0
	#Checking for rows
	while(($index<8))
	do
		if [[ ${board[$index]} == $letter && ${board[$((index+1))]} == $letter && ${board[$((index+2))]} == $IS_EMPTY ]]
		then
			board[$((index+2))]=$computerLetter
			play=1
		return
		elif [[ ${board[$index]} == $letter && ${board[$((index+2))]} == $letter && ${board[$((index+1))]} == $IS_EMPTY ]]
		then
			board[$((index+1))]=$computerLetter
			play=1
		return
		elif [[ ${board[$((index+2))]} == $letter && ${board[$((index+1))]} == $letter && ${board[$index]} == $IS_EMPTY ]]
		then
			board[$index]=$computerLetter
			play=1
		return
		fi
		index=$((index+3))
	done
	index=0
	#Checking for columns
	while(($index<8))
	do
		if [[ ${board[$index]} == $letter && ${board[$((index+3))]} == $letter && ${board[$((index+6))]} == $IS_EMPTY ]]
		then
			board[$((index+6))]=$computerLetter
			play=1
		return
		elif [[ ${board[$index]} == $letter && ${board[$((index+6))]} == $letter && ${board[$((index+3))]} == $IS_EMPTY ]]
		then
			board[$((index+3))]=$computerLetter
			play=1
		return
		elif [[ ${board[$((index+3))]} == $letter && ${board[$((index+6))]} == $letter && ${board[$index]} == $IS_EMPTY ]]
		then
			board[$index]=$computerLetter
			play=1
		return
		fi
		index=$((index+1))
	done
	#Checking for primary diagonal
	if [[ ${board[0]} == $letter && ${board[4]} == $letter && ${board[8]} == $IS_EMPTY ]]
	then
		board[8]=$computerLetter
		play=1
	return
	elif [[ ${board[0]} == $letter && ${board[8]} == $letter && ${board[4]} == $IS_EMPTY ]]
	then
		board[4]=$computerLetter
		play=1
	return
	elif [[ ${board[8]} == $letter && ${board[4]} == $letter && ${board[0]} == $IS_EMPTY ]]
	then
		board[0]=$computerLetter
		play=1
	return
	fi
	#Checking for secondary diagonal
	if [[ ${board[2]} == $letter && ${board[4]} == $letter && ${board[6]} == $IS_EMPTY ]]
	then
		board[6]=$computerLetter
		play=1
	return
	elif [[ ${board[2]} == $letter && ${board[6]} == $letter && ${board[4]} == $IS_EMPTY ]]
	then
		board[4]=$computerLetter
		play=1
	return
	elif [[ ${board[6]} == $letter && ${board[4]} == $letter && ${board[2]} == $IS_EMPTY ]]
	then
		board[2]=$computerLetter
		play=1
	return
	fi
}
#Filling corners randomly
function fillCorners()
{
	local letter=$1
	play=0
	randomCorner=$((RANDOM%4))
	case $randomCorner in
	0)
		if [[ ${board[0]} == $IS_EMPTY ]]
		then
			board[0]=$letter
			play=1
			return
		else
			fillCorners $letter
		fi
	;;
	1)
		if [[ ${board[2]} == $IS_EMPTY ]]
		then
			board[2]=$letter
			play=1
			return
		else
			fillCorners $letter
		fi 
	;;
	2)
		if [[ ${board[6]} == $IS_EMPTY ]]
		then
			board[6]=$letter
			play=1
			return
		else
			fillCorners $letter
		fi 
	;;
	3)
		if [[ ${board[8]} == $IS_EMPTY ]]
		then
			board[2]=$letter
			play=1
			return
		else
			fillCorners $letter
		fi
	;; 
	esac
}
#Take a centre
function takeCenter()
{
	computerLetter=$1
	play=0
	if [[ ${board[4]} == $IS_EMPTY ]]
	then
		board[4]=$computerLetter
		play=1
	fi
}
#Function to take any one side
function takeSides()
{
	local letter=$1
   play=0
   randomSides=$((RANDOM%4))
   case $randomSides in
	0)
		if [[ ${board[1]} == $IS_EMPTY ]]
		then
			board[1]=$letter
			play=1
			return
		else
			takeSides $letter
		fi
	;;
	1)
		if [[ ${board[3]} == $IS_EMPTY ]]
		then
			board[3]=$letter
			play=1
			return
		else
			takesSides $letter
		fi 
	;;
	2)
		if [[ ${board[5]} == $IS_EMPTY ]]
		then
			board[5]=$letter
			play=1
			return
		else
			takeSides $letter
		fi 
	;;
	3)
		if [[ ${board[7]} == $IS_EMPTY ]]
		then
			board[7]=$letter
			play=1
			return
		else
			takeSides $letter
		fi
	;; 
   esac
}
#Computer turn
function computerTurn()
{
	computerLetter=$1
	playerLetter=$2
	play=0
	echo "Computer turn: "
	check_Block_WiningMove $computerLetter
	if(($play==0))
	then
		check_Block_WiningMove $playerLetter 
	fi
	if(($play==0))
	then
		fillCorners $computerLetter
	fi
	if(($play==0))
	then
		takeCenter $computerLetter
	fi
	if(($play==0))
	then
		takeSides $computerLetter
	fi
	displayBoard
}
#Function to play both the player alternatively
function alternatePlay()
{
	chance="$(whoPlayFirst)"
	flag=0
	if [ "$chance" = "computerChance" ]
	then
		flag=1
	fi
	while ((0==0 ))
	do
		if(( flag%2!=0 ))
		then
			computerTurn $computerLetter $playerLetter
			result=$(checkWin $computerLetter)
			if [[ $result = "win" ]] || [[ $result = "draw" ]]
			then
				printf " Computer $result\n"
				break 
			fi
		else
			playerTurn $playerLetter
			result="$(checkWin $playerLetter)"
			if [[ $result = "win" ]] || [[ $result = "draw" ]]
			then
				printf " Player $result\n"
				break 
			fi
		fi
		flag=$((flag+1))
	done
}
displayBoard
getLetter
alternatePlay
