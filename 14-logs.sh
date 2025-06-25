USERID=$(id -u) # Get the user ID of the current user
R="\e[31m" # Red color
G="\e[32m" # Green color
Y="\e[33m" # yellow color
N="\e[0m"  # No Color

LOGS_FOLDER="/var/logs/shellscript-logs" # Define the logs folder
SCRIPT_NAME=$(echo $0 | cut -d "." -f1) # Get the script name without extension
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log" # Define the log file path

mkdir -p $LOGS_FOLDER

echo "Script started executing at : $(date)" | tee -a $LOG_FILE # Log the start time of the script
if [ $USERID -ne 0 ]
then 
echo -e "$R ERROR:: Please run this script with root access $N" | tee -a $LOG_FILE # Exit if not run as root
exit 1 # give other than 0 to 127
else
echo -e "$G Your running with root access $N" | tee -a $LOG_FILE # Continue if run as root
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "${G}Installing $2 is ... SUCCESS${N}" # If installation was successful
    else
        echo -e "${R}Installing $2 is ... FAILURE${N}" # If installation failed
        exit 1 # Exit with a non-zero status
    fi
}

dnf list installed mysql &>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo "MySQL is not installed... going to install it" | tee -a $LOG_FILE
    dnf install mysql -y &>>$LOG_FILE # Install Mysql
    VALIDATE $? "MySQL" # Validate the installation of MySQL
else
    echo " $Y Mysql is already installed..Nothing to do $N" | tee -a $LOG_FILE# If MySQL is already installed
fi      
dnf list installed python3 &>>$LOG_FILE
if [ $? -ne 0 ] # If python3 is not installed
then 
    echo "Python3 is not installed... going to install it" | tee -a $LOG_FILE
    dnf install python3 -y &>>$LOG_FILE # Install Python3
    VALIDATE $? "Python3" # Validate the installation of Python3
else
    echo " $Y Python3 is already installed..Nothing to do $N" | tee -a $LOG_FILE# If Python3 is already installed
fi
dnf list installed nginx &>>$LOG_FILE
if [ $? -ne 0 ] # If nginx is not installed 
then 
    echo "Nginx is not installed... going to install it" | tee -a $LOG_FILE
    dnf install nginx -y &>>$LOG_FILE # Install Nginx
    VALIDATE $? "Nginx" # Validate the installation of Nginx
else
    echo " $Y Nginx is already installed..Nothing to do $N" | tee -a $LOG_FILE # If Nginx is already installed
fi                        