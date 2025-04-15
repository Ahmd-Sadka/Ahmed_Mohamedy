#!/bin/env bash

# create a swap file of 2GB in size

sudo dd if=/dev/zero of=/swapfile count=2048 bs=1M
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile   none    swap    sw    0   0' | sudo tee -a /etc/fstab
free -m

# install dependencies
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.24.2.linux-amd64.tar.gz
sudo yum update -y
sudo yum install -y git go
export PATH=$PATH:/usr/local/go/bin

sudo useradd -r -s /usr/sbin/nologin -m -c "Gogs" git

git clone --depth 1 https://github.com/gogs/gogs.git gogs
# Change working directory
cd gogs
# Compile the main program, dependencies will be downloaded at this step
go build -o gogs



