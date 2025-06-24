#!/bin/bash

USERID=$(id -u) # Get the user id from  the current user

if [ $USERID -ne 0 ]
then
    echo "ERROR:: Please run this script with root access"
    exit 1
else
    echo "Your running with root access"
fi
# validate functions takes input as exit status, what command they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo "Installing $2 is ... SUCCESS"
    else
        echo "Installing $2 is ... FAILURE"
        exit 1 # Exit with a non-zero status
    fi
}

dnf list installed mysql
if [ $? -ne 0 ] # If mysql is not installed
then 
    echo "MySQL is not installed... going to install it"
    dnf install mysql -y # Install Mysql
    VALIDATE $? "MySQL" # Validate the installation of MySQL
else
    echo "Mysql is already installed..Nothing to do" # If MySQL is already installed
fi

dnf list installed python3
if [ $? -ne 0 ]
then
    echo "Python3 is not installed... going to install it"
    dnf install python3 -y # Install Python3
    VALIDATE $? "Python3" # Validate the installation of Python3
else
    echo "Python3 is already installed..Nothing to do" # If Python3 is already installed
fi

dnf list installed nginx
if [ $? -ne 0 ] # If nginx is not installed
then 
    echo "Nginx is not installed... going to install it"
    dnf install nginx -y # Install Nginx
    VALIDATE $? "Nginx" # Validate the installation of Nginx
else
    echo "Nginx is already installed..Nothing to do" # If Nginx is already installed
fi
