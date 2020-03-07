#!/bin/bash

# This program clears History file (.bash_history) of any repetition, so you'll have an history 
# with new command and argument only.
# It could be usefull in cases where it is necessary to repeat a series of commands several times.
# After after a cleaning, the file will be more easily accessible, and it will be possible to find 
# all commands previously typed in an easier (and faster) way, without using search function
# You can use this program with other purposes... fo example to clean another file...you're allowed
# to modify...it's free licensed...

# FuzzlerNet Productions - 2020

# Welcome message
echo "o========================================o"
echo "| Welcome to HISTORY CLEANER Program !!! |"
echo "o========================================o"
echo "| This tool is meant to clean up bash    |"
echo "| history file from repeated command so  |"
echo "| you so you will be able to browse the  |"
echo "| saved history faster...                |"
echo "| You can also choose another file to be |"
echo "| cleansed if you wish: you've only to   |"
echo "| write file name (exact location) as a  |"
echo "| parameter of the program, this way:    |"
echo "| $ ./history_cleaner.sh file2clean      |"
echo "| Enjoy!!!                                 |"
echo "o========================================o"
echo

# User input
if [ $# -eq 0 ]
then
	file="/home/$USER/.bash_history" #file address (file to be cleansed)
	echo "Since you haven't pass any parameter to program"
	echo "file will be processed is: $file"
	echo
else
	file=$@
	echo "The file you choose to process is: $file"
	echo 
fi

# Variables:
fl=$(wc -l < $file) # number of file-lines (use < to avoid filename print in output)
drow=0; # count of deleted rows
response=0 # user response about how to do
 
echo "Do you wish to continue?"
echo "1) Continue processing $file"
echo "2) Exit program"

read response

while [[ $response != 1 && $response != 2 ]]
do
	printf "ERROR! You can choose 1 to continue or 2 to exit program:\n "
	read response
done


if [ $response -eq 1 ]
then

	for (( i = $fl; i > 2 ; i-- )); do

	   	#echo "Welcome $i times"
		line=$(sed -n ${i}p $file)

		echo "Processed line " $i ": " $line
		
		for (( j = $((i - 1)); j > 1 ; j-- )); do
			prev=$(sed -n ${j}p $file)

			#printf "\t $j -> $prev \n" 

			if [ "$line" = "$prev" ];
			then
				sed -i ${j}d $file
				drow=$((drow+1)) #iincrement of deleted row
				#echo "Line $j and line $i have the same content ($prev = $line)"
			fi
		done
	done
else
	echo
	echo "***********************************"
	echo "| You have choose to exit program |"
	echo "***********************************"
	echo
	echo "REMEMBER:"
	echo "*********"
	echo "If you wish to clean a specific file you have to pass it on program launching:"
	echo "\$ ./history_cleaner.sh file2clean"
	echo "Although will be processed .bash_history file (that's the program main purpose...)"
	echo "ByeBye..."
	echo
	exit 0
fi

echo
echo "o===================================o"
echo "| Program executed successfully !!! |"
echo "o===================================o"
echo
echo "Report:"
echo "*******"
printf "Deleted rows: $drow\n"

# The following `sed` command will remove the trailing spaces from the variable
# myVar=`echo $myVar | sed 's/ *$//g'`

# NOTE PER LO SVILUPPO:
# 
# -> -> Possibili PROBLEMI DI COMPARAZIONE TRA LE STRINGHE -> forse risolti...verifica meglio
#
# -> TODO:
# -- INSERIRE FUNZIONE CHE ELIMINA RIGHE CON CONTENUTI DUPLICATI...
# -- SE RIMANGONO LE RIGHE VUOTE VANNO ELIMINATE
# -- FUNZIONE CHE ELIMINA VECCHIO FILE E LO SOSTITUISCE CON QUELLO RIPULITO...(SE SI È FATTA LA COPIA)
# -- FUNZIONE CHE CHIEDE ALL'UTENTE IL NOME DEL FILE ALTERNATIVO / E SE VUOLE ESEGUIRE LO SCRIPT
# -- SE POSSIBILE...TEMPORIZZATORE.. STIMA FINE PROGRAMMA


