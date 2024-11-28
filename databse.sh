Log_folder="/var/log/expense"
Script_name=$(echo $0 | cut -d "." -f1)
timestamp=$(date +%Y-%m-%d-%H-%M-%S)
Log_filename="$Log_folder/$Script_name-$timestamp.log"
mkdir -p $Log_filename

userid=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

validate_root(){
    if [ $userid -eq 0 ]
    then
        echo -e "$G user has root permissions and $Y successfull"
    else
        echo -e "$R user doesn't has root permissions and $Y unsuccessfull"
        exit 1
    fi
}

validate_root
Checking(){
    if [ $1 -ne 0]
    Then
        echo -e "$R $2 is $Y unsuccessful"
        exit 1
    else
        echo -e "$G is $Y succesfull"
    fi

}

lidate_root
Checking $? "install mysql-server"