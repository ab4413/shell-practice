#!/bin/bash
#  write a program if given number is less then 10 or not
NUMBER=$1

if [ "$NUMBER" -lt 10 ]
then
    echo "The given number is less than 10"
else
    echo "The given number is not less than 10"
fi