#!/bin/bash
##!/bin/sh

hash figlet 2>/dev/null || { echo >&2 "I require figlet but it's not installed.please install figlet and try again"; exit 1; }


function inputArray {   echo "please use CTRL+D for stop input!"
	  		Today=$(date +'%A %F')
	  		echo "Today is:$Today"
          		while read line
          		do
				line=$(sed 's/ /_/g' <<<"$line")
				my_array=("${my_array[@]}" $line)
          		done;}



function deleteArray {  unset my_array
          		echo "your array(temp) enter cleaned!"
          		sleep 2;}


function saveArrayToFile { printf "%s\n" "${my_array[@]}" >> .ToDoList.txt
          		   echo "all Task add to you ToDo list"
                           unset my_array
                           sleep 2;}


function showToDoFile { file=./.ToDoList.txt
          		if [ -f "$file" ]; then
            		    nl .ToDoList.txt | sed 's/_/ /g'
	    		    echo
            		    read -p "Please Press ENTER for continue"
          		else
            		    echo "ToDoList file not exists!"
            		    sleep 2
          		fi;}



function searchToDoFile {  read -p "please enter your Task:" search
			   search=$(sed 's/ /_/g' <<<"$search")
          		   file=./.ToDoList.txt
          		   if [ -f "$file" ]; then
            		   	result=$(cat .ToDoList.txt | grep -nx "$search" | cut -c 1)
            				if [ ! -z "$result" ]; then
						echo "$result"
            				else
						echo 0
            				fi

          		   else
				        echo -1
          		   fi;}


function deleteTask {   file=./.ToDoList.txt
			if [ -f "$file" ] ; then
			search=$(searchToDoFile)
			if [ "$search" == -1 ]; then
        			echo "Unfortunately you dont save any task in your list!"
				sleep 2
			elif [ "$search" == 0 ]; then
				echo "this Task in not defined before!"
				sleep 2
			else
				sed -n "$search"p .ToDoList.txt >> .deleteToDoFile.txt
				sed "$search"d .ToDoList.txt > .temp.txt
				cat .temp.txt > .ToDoList.txt
				echo "this task you enter successful removed!"
				sleep 2
			fi
		else
			echo "you dont save any ToDo"
			sleep 2
		fi;}


function showDeletedTask { file=./.deleteToDoFile.txt
			   if [ -f "$file" ] ; then
			   	nl ./.deleteToDoFile.txt | sed 's/_/ /g'
				echo
            		        read -p "Please Press ENTER for continue"
		           else
			   	echo "You dont have any deleted Task"
			    	sleep 2
			   fi;}


function doneTask {     file=./.ToDoList.txt
			if [ -f "$file" ] ; then
			search=$(searchToDoFile)
			if [ "$search" == -1 ]; then
        			echo "Unfortunately you dont save any task in your list!"
				sleep 2
			elif [ "$search" == 0 ]; then
				echo "this Task in not defined before!"
				sleep 2
			else
				sed -n "$search"p .ToDoList.txt >> .doneToDoFile.txt
				sed "$search"d .ToDoList.txt > .temp.txt
				cat .temp.txt > .ToDoList.txt
				echo "this task you enter Done!"
				sleep 2
			fi
		else
			echo "you dont save any ToDo"
			sleep 2
		fi;}


function showDoneTask { file=./.doneToDoFile.txt
			   if [ -f "$file" ] ; then
			   	nl ./.doneToDoFile.txt | sed 's/_/ /g'
				echo
            		        read -p "Please Press ENTER for continue"
		           else
			   	echo "You dont have any deleted Task"
			    	sleep 2
			   fi;}


function viewHelpFile { cat ./.helpFile.txt 
			figlet ":-)"
            		read -p "Please Press ENTER for continue";}


while :
do
clear
echo "---------------------------------"
figlet -f standard To-Do!
echo "---------------------------------"
echo "1-Add ToDo to array(temp)"
echo "2-Clean array ToDo(temp)"
echo "3-Save array to ToDoList file."
echo "4-View ToDoList file."
echo "5-Search in ToDoList."
echo "6-Done a task."
echo "7-View done Task."
echo "8-Delete a Task from ToDoList file."
echo "9-View deleted Task."
echo "h-View help."
echo "e-Exit ToDo."
read -p "Please enter a number:" command

    case $command in 
        1)
       	  inputArray
          ;;

        2)
	  deleteArray
          ;;


        3)
	  saveArrayToFile
          ;;

        4)
	  showToDoFile
          ;;

	5)
	search=$(searchToDoFile)
	if [ "$search" == -1 ]; then
        	echo "Unfortunately you dont save any task in your list!"
		sleep 2
	elif [ "$search" == 0 ]; then
		echo "it's not here!"
		sleep 2
	else
		echo "yes its here in line $search "
		sleep 2
	fi
	  ;;

  	6)
	  doneTask
	  ;;

  	7)
	  showDoneTask
	  ;;

  	8)
	  deleteTask
	  ;;

  	9)
	  showDeletedTask
          ;;

  	h)
	  viewHelpFile
	  ;;

        e)
          echo "Have a nice day!"
          break;;

        *)
          echo "You enter a wrong input!"
          sleep 2
    esac
done
