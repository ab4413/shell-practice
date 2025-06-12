#!/bin/bash

echo "All variables passed to the script: $*"
echo "Number of variable to the script: $#"
echo "Script name: $0"
echo "Current directory: $PWD"
echo "current user (or) User running the script: $USER"
echo "Home directory of the user: $HOME"
echo "PID of the script: $$"
echo "PID of thhe last comand executed: $1"
# Capture exit status of the previous command (the echo above)
last_status=$?
echo "Exit status of the last command executed: $last_status"

sleep 10 &
echo "PID of last command in background: $!"