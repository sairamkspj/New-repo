Log_folder="/var/log/expense"
Script_name=$(echo $0 | cut -d "." -f1)
timestamp=$(date +%Y-%m-%d-%H-%M-%S)
Log_filename="$Log_folder/$Script_name-$timestamp.log"
mkdir -p $Log_folder

userid=$(id -u) &>>$Log_filename
R="\e[31m"
G="\e[32m"
Y="\e[33m"

validate_root(){
    if [ $userid -eq 0 ]
    then
        echo -e "$G user has root permissions and $Y successfull" | tee -a $Log_filename
    else
        echo -e "$R user doesn't has root permissions and $Y unsuccessfull"
        exit 1
    fi
}

validate_root
Checking(){
    if [ $1 -ne 0 ]
    then
        echo -e "$R $2 is $Y unsuccessful"
        exit 1
    else
        echo -e "$G $2 is $Y succesfull"
    fi
}

dnf install mysql-server -y
Checking $? "install mysql-server"

systemctl enable mysqld
Checking $? "enable mysqld"

systemctl start mysqld
Checking $? "start mysqld"

# mysql_secure_installation --set-root-pass ExpenseApp@1
# Checking $? "password changing"
nslookup mysql.saiawsdev.shop
if [ $? -eq 0 ]
then
    mysql -h mysql.saiawsdev.shop -u root -pExpenseApp@1
    echo "$Y performing passwordcreation task"
else
    echo -e "$R connection is unsuccesfull"
    exit 1
fi


if [ $? -ne 0 ]
then
    echo -e "$G connection is unsuccessful $Y creating paasword now"
    mysql_secure_installation --set-root-pass ExpenseApp@1
    Checking $? "password creation"
else
    echo -e "$G password is already set up skipping creation"
fi

