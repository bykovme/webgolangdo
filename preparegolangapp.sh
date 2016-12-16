#!/bin/bash

OS=`lsb_release -i`

if [[ $OS == *"Ubuntu"* ]]; then
  	echo "Ubuntu detected"
  	lsb_release  -d -r -c
else 
	echo  "This script is supposed to work only in Ubuntu, stopping execution"
	exit 1
fi

# Install required packages

# install git
apt -y install git

# install mysql 
apt -y install mysql

# install nginx

apt -y install nginx

echo "Fill the username to be used for maintaining golang web application (cannot be 'root'!), followed by [ENTER]:"

read USERNAME

echo 
