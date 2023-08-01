#!/bin/bash

sudo apt-get update

# Install Docker
sudo apt-get install -y docker.io

# Add user to the docker group
sudo usermod -aG docker $USER

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Make the binary executable
sudo chmod +x /usr/local/bin/docker-compose

# Make the SQL repository visible to pgadmin
sudo chown -R 5050:5050 SQL

# Create usergroup pgadmin on hostmachine
sudo groupadd -g 5050 pgadmin

# Add user to the pgadmin group
sudo usermod -aG 5050 $USER

# makes adds w permission for group members on SQL directory
sudo chmod -R 775 SQL

docker --version
docker-compose --version