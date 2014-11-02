#!/usr/bin/python
# -*- coding: utf-8 -*-

##############
# dockerComp #
##############
from app import app
from app.models import *
from flask import \
    Flask, \
    render_template, \
    Response, \
    json, \
    make_response, \
    request, \
    redirect, \
    session, \
    abort, \
    send_from_directory

from config import \
    HOST, \
    PORT, \
    DEBUG,\
    TEMPLATE_CONFIGURATION

from random import randrange


@app.route('/', methods=['GET','POST'])
def home():
    """
    dockerComp Container Management dashboard
    """
    print request.headers['Host'], request.method
    return render_template('index.html',
                           **TEMPLATE_CONFIGURATION)


@app.route('/<container_id>/')
def listener(container_id=None):
    """
    listens for possible connections
    made by container.
    """
    pass
    

def data_generator():
    """
    generates random datasets.
    """
    temp = []
    for i in xrange(10):
        temp.append((randrange(100),
                     randrange(100)))
    

def integrity_checker(container_id=None, data=None):
    """
    checks and verifies data sent over by  containers
    """
    current = Client.objects.get(container_id=container_id)

    
@app.route('/connect/<client_IP>/<container_id>/', methods=['GET','POST'])
def communicator(container_id=None, client_IP=None):
    """
    communicates with the client
    """
    if request.method == 'POST': 
        pass
    elif request.method == 'GET':
        pass


if __name__ == '__main__':
    try:
        app.run(host = HOST,
                port = PORT,
                debug = DEBUG)
    except:
        raise
