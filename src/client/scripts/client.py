#!/usr/bin/python2
# -*- coding: utf-8 -*-

import socket 

# Create a socket object
s = socket.socket()
# Get local machine name
host = socket.gethostname() 
# Reserve a port for your service.
port = 8088

s.connect((host, port))
print s.recv(8089)
# Close the socket when done
s.close                     
