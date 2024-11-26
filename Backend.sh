userid=$(id -u)
scriptname=$(echo "$0" | cut -d "." -f2)
echo "$userid data $scriptname"