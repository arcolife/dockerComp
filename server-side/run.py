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
    jsonify, \
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
import netaddr

import subprocess
from subprocess import call
# from subprocess import check_out

@app.route('/', methods=['GET'])
def home():
    """
    dockerComp Container Management dashboard
    """
    try:
        #print request.path
        assert request.path == '/'
        print request.headers['Host'], request.method
        return render_template('index.html',
                               **TEMPLATE_CONFIGURATION)
    except:
        abort(404)
        
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
    return temp

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


@app.route('/test/server/', methods=['POST'])
def test():
    print request.host
    return "\n>>>> Server: Client POST request OK Tested" #jsonify({'got response from client': 'OK'})

@app.route('/get_details/', methods=['POST'])
def get_tasks():
    received = json.loads(request.data)
    ip_addr = request.environ['REMOTE_ADDR']
    ip_addr_num = netaddr.IPAddress(ip_addr).value
    
    try:
        temp_client = Client.objects.get(ip_addr=ip_addr)
    except:
        temp_client = Client(ip_addr=ip_addr,
                             ip_addr_num=ip_addr_num)

    for data in received:
        container_port = data['NetworkSettings']['Ports']\
                         ['80/tcp'][0]['HostPort']
        container_id = data['Config']['Hostname']
        container_name = data['Name']
        container_ip_addr = data['NetworkSettings']['IPAddress']
        temp_container = Container(container_name=container_name,
                                   container_ip_addr=container_ip_addr,
                                   container_id=container_id,
                                   container_port=container_port,
                                   config=data)

        temp_client.containers[container_port] = temp_container
        temp_client.save()
        
    #print temp_client.to_json()
    print request.host
    return '\n>>>> Server: container metadata received..\n'

# a round-robin fashion
@app.route('/assign/all', methods=['POST'])
def assign_all():
    # dockerIDs = check_output(["docker","ps","-q"])
    # print type(dockerIDs)
    # print dockerIDs
    p = subprocess.Popen(["docker", "ps", "-q"], stdout=subprocess.PIPE)
    out, err = p.communicate()
    for i in out.split():
        info = subprocess.Popen(["docker","inspect",i], stdout=subprocess.PIPE)
        info_out, err_out = info.communicate()
        cip = json.loads(info_out)[0]['NetworkSettings']['IPAddress']
        data = data_generator()
        # print data
        # print "****"
        # subprocess.Popen(["scripts/test_client.sh",cip,str(data)], stdout=subprocess.PIPE)
        # print "****"
        subprocess.Popen(["curl","-H","Content-type: application/json","-X","POST","http://"+cip+"/tasks","-d",str(data)], stdout=subprocess.PIPE)
        # curl -H "Content-type: application/json" -X POST http://$1/tasks/ -d "$2"

if __name__ == '__main__':
    try:
        app.run(host = HOST,
                port = PORT,
                debug = DEBUG)
    except:
        raise
