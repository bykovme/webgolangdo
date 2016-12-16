#!/bin/bash

OS=`lsb_release -i`

if [[ $OS == *"Ubuntu"* ]]; then
  	echo "Ubuntu detected"
  	lsb_release  -d -r -c
else 
	echo  "This script is supposed to work only in Ubuntu, stopping execution"
	exit 1
fi

echo "This script will install nginx, mysql, golang and change a lot of configurations in /etc"
echo "Run this script only on the clean ubuntu otherwise it can break you configuration"
echo -n "Type 'yes' if you understand what you are doing: "

read YES

if [ $YES != "yes" ]; then
	echo "Stopping execution"
	exit 1
fi

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root, stopping execution" 
   	exit 1
fi

# Install essential packages

# install git
apt -y install git

# install mysql 
apt -y install mysql

# install nginx

apt -y install nginx

echo -n "Fill the username to be used for maintaining golang web application (cannot be 'root'!), followed by [ENTER]:"

read USERNAME

echo "Entered username: $USERNAME" 
