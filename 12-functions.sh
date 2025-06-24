USERID=$(id -u)

if [$USERID is -ne 0 ]
then
   echo "ERROR::Plese run this script with root access"
   exit 1 #
else 
   echo "your running this script with root access"

fi