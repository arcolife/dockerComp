#!/bin/bash

user_interrupt(){
    echo -e "\n\nKeyboard Interrupt detected."
    echo -e "Stopping Task Manager..."    
    exit
}

trap user_interrupt SIGINT
trap user_interrupt SIGTSTP


start_daemon(){
	while :; do
		
		# # install cadvisor
		# sudo docker run   --volume=/:/rootfs:ro   --volume=/var/run:/var/run:rw  \
		#  --volume=/sys:/sys:ro   --volume=/var/lib/docker/:/var/lib/docker:ro   \
		#  --publish=8080:8080   --detach=true   --name=cadvisor   \
		#  google/cadvisor:latest
	    echo "test"


	done
}