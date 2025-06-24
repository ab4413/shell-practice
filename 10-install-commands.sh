#!/bin/bash

USERID=$(id -u) # Get the user ID of the current user
if [ $USERID -ne 0 ]
then
    echo "ERROR:: Please run this script with root access" # Exit if not run as root
    exit 1 # give other than 0 to 127
else
    echo "Your runninng with root access" # Continue if run as root
fi

# Install commands
dnf list installed mysql # Check if MySQL is installed

#check if already installed or not. If installed $? is 0, then
# if not installed $? is not 0. expression is true.

if [ $? -ne 0 ] # If mysql is not installed
then 
    echo "MySQL is not installed... going to install it"
    dnf install mysql -y # Install Mysql
    if [ $? -eq 0 ]
    then
        echo "Installing MySQL is ... SUCCESS" # If installation was successful
    else
        echo "Installing MySQL is ... FAILURE" # If installation failed
        exit 1 # Exit with a non-zero status
    fi
    
else
    echo "Mysql is already installed..Nothing to do" # If MySQL is already installed

fi 