####################
## Install Docker ##
####################

sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli docker-compose-plugin --allowerasing

sudo systemctl enable docker.service
sudo systemctl start docker.service

sudo usermod -aG docker $USER

cat <<EOF | sudo tee /etc/docker/daemon.json
{
"exec-opts": ["native.cgroupdriver=systemd"],
"log-driver": "json-file",
"log-opts": {
"max-size": "100m"
},
"storage-driver": "overlay2"
}
EOF

sudo systemctl restart docker.service


sudo groupadd -f docker
sudo usermod -aG docker $USER
newgrp docker
