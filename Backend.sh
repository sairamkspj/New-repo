userid=$(id -u)
filepath="/var/log/expense"
scriptname=$(echo "$0" | cut -d "." -f2)
timestamp=$(date +%Y-%m-%d-%H-%M-%S)
logfile="$filepath/$scriptname-$timestamp.log"
mkdir -p $logfile

R="\e[31m"
G="\e[32m"
N="\e[0m"

#first we should check the user is having root privilages

check_root(){
    if [ $userid -ne 0 ]
    then
        echo -e "$G Please run the scrit with root privilages"
        exit 1
        
    fi
}

validate(){
    if [ $1 -eq 0 ]
    then 
        echo -e "$G $2 the above code is  exicuted successfully"
    
    else
        echo -e "$R $2 not succesfull"
    
    fi
}
check_root

echo -e "$G installing for backend"

dnf module disable nodejs -y
validate "$?" "disableing nodejs"

dnf module enable nodejs:20 -y
validate "$?" "enableing nodejs"

dnf install nodejs -y
validate "$?" "installing nodesjs"

useradd expense
validate "$?" "adding expense user"

mkdir -p /app
validate "$?" "directory created"
data=$(ls)

checkinfiles(){
    if [ "$?" eq 0 ]
    then
        echo "data"
    fi
}


#curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip

cd /app
checkinfiles