#!/bin/bash

data1=$1
data2=$2
#mkdir /app
#echo "hello world"
#echo "If you want to print ${data1}"
#echo "if you dont want to print ${data2}"
#read -s username
#echo "we are printing user data ${username}"
#echo "Please enter your username::"
#$(mkdir data)
echo "All variables passed to the script: $@"
echo "Number of variables passed: $#"
echo "Script name: $0"
echo "Current working directory: $PWD"
echo "Home directory of current user: $HOME"
echo "PID of the script executing now: $$"
sleep 100 &
echo "PID of last background command: $!"
number=$1

if [ $number -gt 0 ]
then
    echo "$number is greater then zero"
else
    echo "$number is less than zero"
fi

number1=$2
if [ $number1 -eq 4 ]
then
    if [ $number1 -gt 3 ]
    then
    echo "$number1 is equl to 4"

    echo "$number1 is greater to 3"
    fi
else
    echo "$number1 is not equal to 4"
fi
