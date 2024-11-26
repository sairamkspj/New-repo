userid=$(id -u)
filepath="/var/log/expense"
scriptname=$(echo "$0" | cut -d "." -f2)
timestamp=$(date +%Y-%m-%d-%H-%M-%S)
logfile="$filepath/$s