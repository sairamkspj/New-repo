Log_folder="/var/log/expense"
Script_name=$(echo $0 | cut -d "." -f1)
timestamp=$(date +%Y-%m-%d-%H-%M-%S)
Log_filename="$Log_folder/$Script_name-$timestamp.log"
mkdir -p $Log_folder

userid=$(id -u) 
echo "User ID: $userid" &>>$Log_filename
echo "$G user has root permissions and $Y successfull" | tee -a $Log_filename
R="\e[31m"
G="\e[32m"
Y="\e[33m"

validate_root(){
    if [ $userid -eq 0 ]
    then
        echo -e "$G user has root permissions and $Y successfull" | tee -a $Log_filename
    else
        echo -e "$R user doesn't has root permissions and $Y unsuccessfull" | tee -a $Log_filename
        exit 1
    fi
}

validate_root
Checking(){
    if [ $1 -ne 0 ]
    then
        echo -e "$R $2 is $Y unsuccessful" | tee -a $Log_filename
        exit 1
    else
        echo -e "$G $2 is $Y succesfull" | tee -a $Log_filename
    fi
}

dnf install mysql-server -y &>>$Log_filename
Checking $? "install mysql-server"

systemctl enable mysqld &>>$Log_filename
Checking $? "enable mysqld"

systemctl start mysqld &>>$Log_filename
Checking $? "start mysqld"

# mysql_secure_installation --set-root-pass ExpenseApp@1
# Checking $? "password changing"
nslookup mysql.saiawsdev.shop &>>$Log_filename
if [ $? -eq 0 ]
then
    mysql -h mysql.saiawsdev.shop -u root -pExpenseApp@1 &>>$Log_filename
    echo -e "$Y performing passwordcreation task" | tee -a $Log_filename
else
    echo -e "$R connection is unsuccesfull" | tee -a $Log_filename
    exit 1
fi


if [ $? -eq 0 ]
then
    echo -e "$G connection is unsuccessful $Y creating paasword now" | tee -a $Log_filename
    mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$Log_filename
    Checking $? "password creation"
else
    echo -e "$G password is already set up skipping creation" | tee -a $Log_filename
fi

