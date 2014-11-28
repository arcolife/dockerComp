#!/bin/bash

user_interrupt(){
    echo -e "\n\nKeyboard Interrupt detected."
    echo -e "Cleaning Up and terminating..."
    sudo rm -rf src/
    exit
}

trap user_interrupt SIGINT
trap user_interrupt SIGTSTP

initial_steps(){
    # init
    #readonly SERVER_IP='localhost' 
    echo "export SERVER_D='localhost'" >> ~/.bashrc
    export SERVER_D='localhost'

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
}

setup_app(){
    git clone https://github.com/arcolife/dockerComp.git
    cd dockerComp/client-side
    sudo ./launch.sh
    sudo ./test.sh
}

initial_steps
setup_app
