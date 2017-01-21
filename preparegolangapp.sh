#!/bin/bash

# Find the latest version of the script here
# https://github.com/bykovme/webgolangdo

# Run the latest version of the script directly in command line with the command below
# bash <(curl -s https://raw.githubusercontent.com/bykovme/webgolangdo/master/preparegolangapp.sh)

GOLANG_URL="https://storage.googleapis.com/golang/go1.7.4.linux-amd64.tar.gz"
OS=`lsb_release -i`

if [[ $OS == *"Ubuntu"* ]]; then
  	echo "Ubuntu detected"
  	lsb_release  -d -r -c
else 
	echo  "This script is supposed to work only in Ubuntu, stopping execution"
	exit 1
fi

echo "This script will install git, nginx, mysql, golang and change a lot of configurations in /etc"
echo "Run this script only on the clean ubuntu otherwise it can break you configuration"
echo -n "Type 'yes' if you understand what you are doing: "

read YES

if [ $YES != "yes" ]; then
	echo "Stopping execution"
	exit 1
fi

# check if current user has root privileges
if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root, stopping execution" 
   	exit 1
fi

# request root password for mysql
echo -n "Type the password to be used for mysql: "
read MYSQL_PASS

# type it again 
echo -n "Type the password again to confirm it: "
read MYSQL_PASS2

# check if it is the same
if [ $MYSQL_PASS != $MYSQL_PASS2 ]; then
	echo "Password was not confirmed, stopping execution"
	exit 1
fi

# Install essential packages

# install expect
apt -y install expect

# install git
apt -y install git

# install mysql quietly

debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_PASS"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_PASS"

apt -y install mysql-server

# secure mysql, the idea is taken from here https://gist.github.com/Mins/4602864

SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"$MYSQL_PASS\r\"
expect \"Change the root password?\"
send \"n\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$SECURE_MYSQL"

mysql_install_db
service mysql status

# install nginx

apt -y install nginx

# install Go

echo  "Installing go language... "
wget -O golang.tar.gz https://storage.googleapis.com/golang/go1.7.4.linux-amd64.tar.gz
tar -C /usr/local -xzf golang.tar.gz

echo -n "Fill the username to be used for maintaining golang web application (cannot be 'root'!), followed by [ENTER]:"

read USERNAME

echo "Entered username: $USERNAME" 

adduser $USERNAME
usermod -aG sudo $USERNAME

runuser -l $USERNAME -c 'mkdir go'
runuser -l $USERNAME -c "echo \"\nexport GOPATH=$HOME/go\n\" >> ~/.bashrc"

echo "Checking if GO was installed correctly..."
runuser -l $USERNAME -c 'go env'

echo "installing golang webapp, type the address otherwise default sample "
echo "will be taken from "

