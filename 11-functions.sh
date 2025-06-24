USERID=$(id -u) # Get the user id from  the current user

if [ $USERID -ne 0 ]
then
    echo "ERROR:: Plese run this script with root access"
    exit 1
else
    echo "Your running with root access"
fi