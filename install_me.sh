#!/bin/bash

# define your server hostname here; default name defined below..
SERVER_HOSTNAME=$(echo  $HOSTNAME  | awk -F'.' '{print $1}')
# SERVER_HOSTNAME=""

user_interrupt(){
    echo -e "\n\nKeyboard Interrupt detected."
    echo -e "Cleaning Up and terminating..."
    sudo rm -rf src/
    exit
}

trap user_interrupt SIGINT
trap user_interrupt SIGTSTP

setup_env(){
    check_env=$(grep SERVER_D ~/.bashrc)
    if [[ -z $check_env ]]
    then
	echo "export SERVER_D='"$SERVER_HOSTNAME"'" >> ~/.bashrc
    else
	sed -i "s/.*SERVER_D=.*/export SERVER_D='$SERVER_HOSTNAME'/g" ~/.bashrc 
    fi
    export SERVER_D=$SERVER_HOSTNAME
}

setup_deps(){
    echo "What's your package manager?"
    echo "1. APT"
    echo "2. YUM"
    read opt
    if [ $opt -eq 1 ]; then
	sudo apt-get install -y git docker.io python-pip
	sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker
	sudo sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io
	source /etc/bash_completion.d/docker.io
	sudo pip install flask
    elif [ $opt -eq 2 ]; then
	sudo yum -y install docker-io python-pip
	sudo systemctl start docker
	sudo systemctl enable docker
	sudo pip install flask
    else
	echo "Wrong choice! Program Terminated!"
	echo "Error: Unable to continue for this very reason!"
	exit
    fi
    sudo usermod -a -G docker $USER
    #sudo newgrp docker
}

setup_app(){
    git clone https://github.com/arcolife/dockerComp.git
    cd dockerComp/client-side
    sudo ./launch.sh $SERVER_D
    sudo ./test.sh $SERVER_D
}

setup_env
setup_deps
setup_app
