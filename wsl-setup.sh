#!/bin/bash

# Environment variables you need to set so you don't have to edit the script below.

DOCKER_CHANNEL=edge
DOCKER_COMPOSE_VERSION=1.16.1

# Pick the release channel.
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   ${DOCKER_CHANNEL}"

# Update the apt package index.
sudo apt-get update

# Install packages to allow apt to use a repository over HTTPS.
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    zsh \

# Setup ZSH and FZF and wire it into bash
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
echo zsh > ~/.bash_profile
echo source ~/.bash_profile > ~/.bashrc

# Fix pesky color issues with WSL
echo "LS_COLORS=\"ow=01;36;40\" && export LS_COLORS
> zstyle ':completion:*' list-colors \"\${(@s.:.)LS_COLORS}\"
> autoload -Uz compinit
> compinit" > ~/.zshrc

# Grab SSH Keys from the host
cp /mnt/c/Users/jesse/.ssh -R ~/
chmod 400 ~/.ssh/id_rsa

git config --global user.email "jesse.r.carter@gmail.com"
git config --global user.name "Jesse Carter"
git config --global core.editor "vim"

# Running docker on WSL references: https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly
# Add Docker's official GPG key.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Verify the fingerprint.
sudo apt-key fingerprint 0EBFCD88

# Update the apt package index.
sudo apt-get update

# Install the latest version of Docker CE.
sudo apt-get install -y docker-ce

# Allow your user to access the Docker CLI without needing root.
sudo usermod -aG docker $USER

# Point docker at the daemon running on the host machine
echo "export DOCKER_HOST=tcp://0.0.0.0:2375" >> ~/.zshrc && source ~/.zshrc

# Install Docker Compose.
sudo curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose &&
sudo chmod +x /usr/local/bin/docker-compose

# Fix docker mount issues
sudo mkdir /c
sudo mount --bind /mnt/c /c
