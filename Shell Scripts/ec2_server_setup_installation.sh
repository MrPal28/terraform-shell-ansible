#!/bin/bash

set -e

echo "Updating packages..."
sudo apt-get update -y

echo "Installing Git..."
sudo apt-get install -y git

echo "Installing unzip..."
sudo apt-get install -y unzip

echo "Installing AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip -o awscliv2.zip

sudo ./aws/install

echo "Validating AWS CLI installation..."
if command -v aws >/dev/null 2>&1; then
    aws --version
    echo "AWS CLI installed successfully."
else
    echo "AWS CLI installation failed."
    exit 1
fi

echo "Adding HashiCorp repository..."
wget -O- https://apt.releases.hashicorp.com/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

echo "Installing Terraform..."
sudo apt-get update -y
sudo apt-get install -y terraform

echo "Validating Terraform installation..."
if command -v terraform >/dev/null 2>&1; then
    terraform --version
    echo "Terraform installed successfully."
else
    echo "Terraform installation failed."
    exit 1
fi

echo "All installations completed successfully."