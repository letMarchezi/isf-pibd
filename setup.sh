#!/bin/bash

sudo apt-get update

# Install Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add user to the docker group
sudo usermod -aG docker vira-tempo

# Make the binary executable
sudo chmod +x /usr/local/bin/docker-compose

# Make the SQL repository visible to pgadmin
sudo chown -R 5050:5050 SQL

# Create usergroup pgadmin on hostmachine
sudo groupadd -g 5050 pgadmin

# Add user to the pgadmin group
sudo usermod -aG 5050 vira-tempo

# makes adds w permission for group members on SQL directory
sudo chmod -R 775 SQL

docker --version
docker-compose --version