#!/bin/bash

USERID=$(id -u) # Get the user ID of the current user
R="\e[31m" # Red color
G="\e[32m" # Green color
Y="\e[33m" # yellow color
N="\e[0m"  # No Color

if [ $USERID -ne 0 ]
then 
    echo -e "${R}ERROR:: Please run this script with root access${N}" # Exit if not run as root
    exit 1 # give other than 0 to 127
else
    echo -e "${G}Your running with root access${N}" # Continue if run as root
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

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo "MySQL is not installed... going to install it"
    dnf install mysql -y # Install Mysql
    VALIDATE $? "MySQL" # Validate the installation of MySQL
else
    echo " $Y Mysql is already installed..Nothing to do $N" # If MySQL is already installed
fi      
dnf list installed python3
if [ $? -ne 0 ] # If python3 is not installed
then 
    echo "Python3 is not installed... going to install it"
    dnf install python3 -y # Install Python3
    VALIDATE $? "Python3" # Validate the installation of Python3
else
    echo " $Y Python3 is already installed..Nothing to do $N" # If Python3 is already installed
fi
dnf list installed nginx
if [ $? -ne 0 ] # If nginx is not installed 
then 
    echo "Nginx is not installed... going to install it"
    dnf install nginx -y # Install Nginx
    VALIDATE $? "Nginx" # Validate the installation of Nginx
else
    echo " $Y Nginx is already installed..Nothing to do $N" # If Nginx is already installed
fi                        