#!/bin/bash

cd ~
mkdir go
printf "\nexport GOPATH=/home/$0/go\n" >> ~/.bashrc
GOPATH=/home/$0/go
echo "Checking if GO was installed correctly..."
go env