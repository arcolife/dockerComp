#!/usr/bin/python

import os, sys#, time
from flask import Flask, jsonify, request, redirect
#from datetime import datetime

app = Flask(__name__, static_url_path='')

# @app.before_request
# def before_request():
#     pass

@app.route('/test/', methods=['GET', 'POST'])
def test():
    if request.method == 'POST':
        resp = 'POST: this is Client.'
        return Response(resp)
    else:
        return Response('GET: this is Client')


@app.route('/tasks/', methods=['POST'])
def get_tasks():
    #headers = {'content-type': 'application/json'}
    data = []
    return jsonify(data)
    # return Response(data, status=200, 
    #                 mimetype='application/json')
    
        

if __name__ == '__main__':
    try:
        app.run(host = '0.0.0.0',
                port = 5000,
                debug = True)
    except:
        raise

