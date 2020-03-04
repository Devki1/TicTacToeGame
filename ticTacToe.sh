#!/bin/bash -x
declare -a board
echo "Welcome to Tic Tac Toe Game"
board=(" " " " " " " " " " " " " " " " " ")
DOT=0
CROSS=1
USER=0
COMPUTER=1
IS_EMPTY=" "
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
function checkWiningMove()
{
	local letter=$1
	index=0
	#Checking for rows
	while(($index<8))
	do
		if [[ ${board[$index]} == $letter && ${board[$((index+1))]} == $letter && ${board[$((index+2))]} == $IS_EMPTY ]]
		then
			board[$((index+2))]=$letter
			play=1
		return
		elif [[ ${board[$index]} == $letter && ${board[$((index+2))]} == $letter && ${board[$((index+1))]} == $IS_EMPTY ]]
		then
			board[$((index+1))]=$letter
			play=1
		return
		elif [[ ${board[$((index+2))]} == $letter && ${board[$((index+1))]} == $letter && ${board[$index]} == $IS_EMPTY ]]
		then
			board[$index]=$letter
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
			board[$((index+6))]=$letter
			play=1
		return
		elif [[ ${board[$index]} == $letter && ${board[$((index+6))]} == $letter && ${board[$((index+3))]} == $IS_EMPTY ]]
		then
			board[$((index+3))]=$letter
			play=1
		return
		elif [[ ${board[$((index+3))]} == $letter && ${board[$((index+6))]} == $letter && ${board[$index]} == $IS_EMPTY ]]
		then
			board[$index]=$letter
			play=1
		return
		fi
		index=$((index+1))
	done
	#Checking for primary diagonal
	if [[ ${board[0]} == $letter && ${board[4]} == $letter && ${board[8]} == $IS_EMPTY ]]
	then
		board[8]=$letter
		play=1
	return
	elif [[ ${board[0]} == $letter && ${board[8]} == $letter && ${board[4]} == $IS_EMPTY ]]
	then
		board[4]=$letter
		play=1
	return
	elif [[ ${board[8]} == $letter && ${board[4]} == $letter && ${board[0]} == $IS_EMPTY ]]
	then
		board[0]=$letter
		play=1
	return
	fi
	#Checking for secondary diagonal
	if [[ ${board[2]} == $letter && ${board[4]} == $letter && ${board[6]} == $IS_EMPTY ]]
	then
		board[6]=$letter
		play=1
	return
	elif [[ ${board[2]} == $letter && ${board[6]} == $letter && ${board[4]} == $IS_EMPTY ]]
	then
		board[4]=$letter
		play=1
	return
	elif [[ ${board[6]} == $letter && ${board[4]} == $letter && ${board[2]} == $IS_EMPTY ]]
	then
		board[2]=$letter
		play=1
	return
	fi
}
#Computer win randomly play on its turn
function computerTurn()
{
	computerLetter=$1
	play=0
	checkWiningMove $computerLetter
	if(($play==0))
	then
	data=$((RANDOM%9))
	#if no value is assign to index then go ahead else return function
   if [ "${board[$data]}" != X ] && [ "${board[$data]}" != O ]
	then
		echo "Computer turn: "
		board[$data]="$computerLetter"
		else
			computerTurn $computerLetter
	fi
	fi
	resultingBoard
}
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
			computerTurn $computerLetter
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
function blockPlayerWin()
{
	play=0
	letter=$1
	computerLetter=$2
	index=0
	while(($index<8))
	do
		#Checking for rows
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
			playlay=1
			return
		fi
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
		index=$((index+3))
	done
   #Checking for primary diaganol
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
}
#Computer win randomly play on its turn
function computerTurn()
{
	computerLetter=$1
	playerLetter=$2
	play=0
	checkWiningMove $computerLetter
	if(($play==0))
	then
		blockPlayerWin $playerLetter $computerLetter
	fi
	if(($play==0))
	then
		read data
		#if no value is assign to the index then go ahead else return function
		if [ "${board[$data]}" != X ] && [ "${board[$data]}" != O ]
		then
			echo "Computer turn: "
			board[$data]="$computerLetter"
		else
			computerTurn $computerLetter
		fi
	fi
	resultingBoard
}
#function play  both the player alternatvely
function alternatePlay()
{
	chance="$(firstChance)"
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
resultingBoard
getLetter
alternatePlay


