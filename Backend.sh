#!/bin/bash
Log_folder="/var/log/expense"
Script_name=$(echo $0 | cut -d "." -f1)
timestamp=$(date +%Y-%m-%d-%H-%m-%s)
Log_filename="$Log_folder/$Script_name-$timestamp.log"
mkdir -p $Log_filename
userid=$(id -u)

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

validate_root(){
    if [ $1 -eq 0 ]
    then
        echo -e "$G we are performing the task with root privillages" | tee -a $Log_filename
    else
        echo -e " $R we are performing the task with out root privillages" | tee -a $Log_filename
        exit 1
    fi
}

Checking(){
    if [ $1 -eq 0 ]
    then
        echo -e "$G $2 is successfull" | tee -a $Log_filename
    else
        echo -e "$R $2 is unsusccesfull" | tee -a $Log_filename
        exit 1
    fi
}

validate_root "$userid"

dnf module disable nodejs -y >>$Log_filename
Checking "$?" "disable nodejs"

dnf module enable nodejs:20 -y >>$Log_filename
Checking "$?" "enable nodejs:20"

dnf install nodejs -y >>$Log_filename
Checking "$?" "install nodejs:20"

id expense >>$Log_filename

if [ "$?" -nq 0 ]
then
    echo -e "$R user is creating" | tee -a $Log_filename
    useradd expense >>$Log_filename
    Checking "$?" "expense user creation" 
else
    echo -e "$G user is created $Y skipping the user" | tee -a $Log_filename
fi

mkdir -p /app >>$Log_filename
Checking "$?" "creating /app folder"
curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip

cd /app >>$Log_filename
unzip /tmp/backend.zip >>$Log_filename
Checking "$?" "backend code"

npm install >>$Log_filename
Checking "$?" "dependencies install"

cp /home/ec2-user/New-repo/backend.service /etc/systemd/system/backend.service $>>Log_filename

systemctl daemon-reload >>$Log_filename
Checking "$?" "daemon reload"

systemctl start backend >>$Log_filename
Checking "$?" "start backend"

systemctl enable backend >>$Log_filename
Checking "$?" "enable backend"

dnf install mysql -y >>$Log_filename
Checking "$?" "install mysql"

mysql -h <backend.saiawsdev.shop> -uroot -pExpenseApp@1 < /app/schema/backend.sql >>$Log_filename
Checking "$?" "backend connection"

systemctl restart backend >>$Log_filename
Checking "$?" "restart backend"

