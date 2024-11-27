#!/bin/bash
# Log_folder="/var/log/expense"
# Script_name=$("echo $0" | cut -d "." -f1)
# timestamp=$(date +%Y-%m-%d-%H-%m-%s)
# Log_filename="$Log_folder/$Script_name-$timestamp.log"
# mkdir -p $Log_filename
userid=$(id -u)

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

validate_root(){
    if [ $1 -eq 0 ]
    then
    echo " $G we are performing the task with root privillages"
    else
        echo " $R we are performing the task with out root privillages"
        exit 1
    fi
}

validate_root "$userid"
