#!/bin/bash

set -e

sudo apt-get update
sudo apt-get install -y ca-certificates curl

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
	$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
	sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker swarm init
# Run the next commented line for the other two machines
# sudo docker swarm join --token SWMTKN-1-1y5bn....x1ed 192.168.1.220:2377
sudo docker run -it --rm \
	--name swarmpit-installer \
	--volume /var/run/docker.sock:/var/run/docker.sock \
	swarmpit/install:1.9
