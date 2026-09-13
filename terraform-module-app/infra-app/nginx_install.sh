#!/bin/bash

#nginx installation script

sudo apt-get update -y
if [ $? -ne 0 ]; then
    echo "apt update failed. Exiting."
    exit 1
fi

if ! command -v nginx &> /dev/null; then
    echo "nginx is not installed. Installing nginx..."
else
    echo "nginx is already installed."
fi

sudo apt-get install nginx -y

sudo systemctl enable nginx
sudo systemctl start nginx
