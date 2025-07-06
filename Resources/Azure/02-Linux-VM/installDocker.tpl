#!/bin/bash
#script found here: https://medium.com/@david.e.munoz/devops-building-blocks-with-terraform-azure-and-docker-3ad8f78a77c6
#video: https://www.youtube.com/watch?v=V53AHWun17s
sudo apt-get update -y &&
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y &&
sudo apt-get update -y &&
sudo sudo apt-get install docker-ce docker-ce-cli containerd.io -y &&
sudo usermod -aG docker fernando &&
#also install nginx
sudo apt-get update -y &&
sudo apt install nginx -y