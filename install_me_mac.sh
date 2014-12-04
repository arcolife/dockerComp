#!/bin/bash

## TODO: This script is fully automated right now. Needs tweaking. 
## Contributions [especially to 'setup_deps()'] from Mac users are welcome!

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
    echo "1. Brew"
    echo "2. Port"
    read opt
    # TODO: update installation process here..
    if [ $opt -eq 1 ]; then
	# brew install docker
	# sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker
	# sudo sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io
	source /etc/bash_completion.d/docker.io
	sudo pip install flask
    elif [ $opt -eq 2 ]; then
	# sudo yum -y install docker-io python-pip
	# sudo systemctl start docker
	# sudo systemctl enable docker
	# sudo pip install flask
    echo "sorry man"
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
    sudo ./launch.sh $SERVER_D
    sudo ./test.sh $SERVER_D
}

setup_env
setup_deps
setup_app
