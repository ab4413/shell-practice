#!/bin/bash 
echo "Enter your pin number::"
read -s pin # -s option is used to hide the input
echo "your pin number is: $pin"
echo "Enter your name::"
read name
echo "Hello $name, your pin number is: $pin"
echo "Enter your age::"
read age
echo "Hello $name, your pin number is: $pin and your age is: $age"