#!/bin/bash

# To be used for checking dependencies
# Consider the deps to be not present
DOCKER_INSTALLED=0
PIP_INSTALLED=0
FLASK_INSTALLED=0
GIT_INSTALLED=0

user_interrupt(){
    echo -e "\n\nKeyboard Interrupt detected."
    echo -e "Cleaning Up and terminating..."
    if [ -d $DIRECTORY ]; then
        rm -rf $DIRECTORY
    fi   
    exit
}

trap user_interrupt SIGINT
trap user_interrupt SIGTSTP

setup_env(){
    if [ -d $DIRECTORY ]; then
	echo "cleaning up traces of last installation.."
        rm -rf $DIRECTORY
    fi

    if [ -f configuration ]; then
        source configuration
    else
        echo "Config file 'configuration' doesn't exist"
        exit
    fi
    echo $CONTAINER_COUNT
    if [[ -z $DC_HOST ]]; then
    	echo "export DC_HOST='"$SERVER_HOSTNAME"'" >> $HOME/.bashrc
        echo "export DC_PORT='"$SERVER_PORT"'" >> $HOME/.bashrc
        # either source it or set it for current session
        export DC_HOST=$SERVER_HOSTNAME
        export DC_PORT=$SERVER_PORT
    fi
}

check_docker(){
    DOCKER_CMD=$(which docker)
    if [[ ! -z $DOCKER_CMD ]]; then
        DOCKER_INSTALLED=1 # Docker is installed
        echo "Docker is already installed"
    fi
}

check_pip(){
    PIP_CMD=$(which pip2)
    if [[ ! -z $PIP_CMD ]]; then
        PIP_INSTALLED=1 # pip is installed
        echo "pip is already installed"
    fi
}

check_flask(){
    FLASK_CMD=$(python -c "try: import flask; print               
except: print 1")
    if [[ -z $FLASK_CMD ]]; then
        FLASK_INSTALLED=1 # flask is installed
        echo "flask is already installed"
    fi
}

check_git(){
    GIT_CMD=$(which git)
    if [[ ! -z $GIT_CMD ]]; then
        GIT_INSTALLED=1 # git is installed
        echo "Git is already installed"
    fi
}

check_deps(){
    check_docker
    check_pip
    check_flask
    check_git
}

setup_deps(){
    check_deps
    if [ $GIT_INSTALLED -eq 1 ] && [ $DOCKER_INSTALLED -eq 1 ] \
        && [ $PIP_INSTALLED -eq 1 ] && [ $FLASK_INSTALLED -eq 1 ]; 
        then
        echo "All dependencies are statisfied."
        return
    else
        echo "Need to install dependencies which are currently not installed on your system"
        echo "Please enter password for "$USER".."
    fi

    YUM_CMD=$(which yum)
    APT_GET_CMD=$(which apt-get)
    # OTHER_CMD=$(which <other installer>)

    if [[ ! -z $YUM_CMD ]]; then
        command="sudo yum -y install"  # rpm based
    elif [[ ! -z $APT_GET_CMD ]]; then
        command="sudo apt-get install -y" # deb based
    # elif [[ ! -z $OTHER_CMD ]]; then
    #    $OTHER_CMD <proper arguments>
    else
       echo "error can't install package $PACKAGE."
       echo "kindly edit this script to add your package manager in 'OTHER_CMD='"
       exit 1;
    fi

    if [ $GIT_INSTALLED -eq 0 ]; then # install git
    git_install=$command" git"
    eval $git_install
    fi

    if [ $PIP_INSTALLED -eq 0 ]; then # install pip
    pip_install=$command" python-pip"
    eval $pip_install
    fi

    if [ $FLASK_INSTALLED -eq 0 ]; then # install flask
    sudo pip install flask
    fi

    if [ $DOCKER_INSTALLED -eq 0 ]; then # install docker
        if [[ ! -z $APT_GET_CMD ]]; then # deb based
            docker_install=$command" docker.io"
            eval $docker_install
            sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker
            sudo sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io
            source /etc/bash_completion.d/docker.io
        fi

        if [[ ! -z $YUM_CMD ]]; then # rpm based
            docker_install=$command" docker-io"
            eval $docker_install
            sudo systemctl start docker
            sudo systemctl enable docker
        fi
    fi
}


setup_app(){
    cd $HOME
    git clone https://github.com/arcolife/dockerComp.git $DIRECTORY
    cd $DIRECTORY
    # remove server side code, useless for normal users
    git config core.sparseCheckout true
    echo src/client/ > .git/info/sparse-checkout
    git checkout master
    cd src/client/scripts/
    
    echo -e "launching workers.."
    ./launch_workers $CONTAINER_COUNT
    
    echo -e "testing connection to server.."
    ./test_server_conn
    
    # # copy the client daemon from here
    # cp ./scripts/slave_manager $HOME/
    # echo -e "\n..cleaning up and removing "$DIRECTORY
    # rm -rf $DIRECTORY
    # cd $HOME

    echo -e "\n starting the client task manager daemon now.."
    nohup ./slave_manager &
}

setup_env
setup_deps

if [[ -z $(cat /etc/group | grep docker | grep $USER) ]]; then
    echo 'need sudo to add $USER to "docker" group.'
    sudo usermod -a -G docker $USER
    echo
    echo "..added user to docker group."
    echo "..this script will stop executing now, run it again."
    newgrp docker
else
    setup_app
fi
