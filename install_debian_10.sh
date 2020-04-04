#!/bin/bash

if [[ "$EUID" = 0 ]]; then
  echo "Starting environment install on debian 10"

  echo "Installing CURL"
  sudo apt install curl

  echo "Installing WGET"
  sudo apt install wget
  
  if [ ! -z "$1" ] && [ $1 == "--first" ] ; then
    echo "Wich username?"
    read name

    sudo adduser $name

    echo "Installing Google Chrome"

    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ./google-chrome-stable_current_amd64.deb
    
    echo "Installing Wifi Atheros"
    sudo sed -i 's/main/main contrib non-free/' /etc/apt/sources.list
    sudo apt update

    sudo apt install firmware-atheros

    echo "Installing Terminator"
     
    sudo apt install terminator
  fi

  echo "Installing Development Enviroment"

  echo "Installing GIT"
  sudo apt install git

  echo "Installing GIT Flow"
  sudo apt-get install git-flow

  echo "Installing Docker"
  sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
  
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/debian \
     $(lsb_release -cs) \
     stable"
     
  sudo apt-get update

  sudo apt-get install docker-ce docker-ce-cli containerd.io

  sudo groupadd docker
  sudo usermod -aG docker $USER

  echo "Installing Docker-Compose"
  sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

  echo "Installing VSCode"
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft-archive-keyring.gpg
  sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  
  sudo apt-get install apt-transport-https
  sudo apt-get update
  sudo apt-get install code
  
  echo "Installing NVM and Node"
  wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

  nvm install node

  echo "Installing yarn"
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt update && sudo apt install --no-install-recommends yarn

  echo "Installing Insomnia"
  echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list
  wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
    | sudo apt-key add -
   
  sudo apt-get update
  sudo apt-get install insomnia

  echo "Installing Postbird"
  sudo apt install snapd
  systemctl start snapd.service
  sudo snap install postbird

  echo "Installing react-app"
  npm install -g create-react-app

  echo "Installing react-native-CLI"
  npm install -g react-native-cli

  echo "Installing default JDK"
  sudo apt install -y default-jdk

  echo "Installing Android Studio"
  sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
  sudo apt-get install qemu-kvm libvirt-clients libvirt-daemon-system
  sudo adduser $USER libvirt
  sudo adduser $USER libvirt-qemu
    
  echo "Done"
else
  echo "Must run with root"
  exit 1
fi
