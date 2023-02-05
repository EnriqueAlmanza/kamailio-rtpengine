#!/bin/bash
########################################################################
###This script install the prerequisite software for Debian or Ubuntu###
########################################################################
############################ Ubuntu ####################################
sudo apt-get install \
     aptitude nano sngrep \
     terminator -y
VERSION=$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"')
if [[ $VERSION = "ubuntu" ]]
then
  clear
  echo "Ubuntu detected"
  echo "Installing prerequisite software for Ubuntu"
  echo "Uninstall old versions"
  sudo apt-get remove docker docker-engine docker.io containerd runc
  echo "Updating apt package"
  sudo apt-get update
  sudo apt-get install \
      ca-certificates \
      curl \
      gnupg \
      lsb-release -y
  echo "Adding Docker´s official GPG key"
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo "Setting up repository"
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | \ sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  sudo apt-get update -y
  echo "Installing latest version"
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
  echo "Complete"
  sudo docker run hello-world
elif [[ $VERSION == "debian" ]]
then
############################ Debian ####################################
  echo "Debian detected"
  echo "Installing prerequisite software for Debian"
  echo "Uninstall old versions"
  sudo apt-get remove docker docker-engine docker.io containerd runc
  echo "Updating apt package"
  sudo apt-get update
  sudo apt-get install \
      ca-certificates \
      curl \
      gnupg \
      lsb-release -Y
  echo "Adding Docker´s official GPG key"
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo "Setting up repository"
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  sudo apt-get update -y
  echo "Installing latest version"
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
  sudo docker run hello-world
else
  echo "You are using a distribution different than Ubuntu or Debian, \
  please refer to the Docker documentation"
fi
echo "Installing docker compose"
sudo apt-get install docker-compose-plugin