#!/usr/bin/python

import json
import os, sys
from flask import Flask, jsonify, request

app = Flask(__name__, static_url_path='')

@app.route('/test/client/', methods=['POST'])
def test():
    print request.data
    return jsonify({'got response from server': 'OK'})


@app.route('/tasks/', methods=['POST'])
def get_tasks():
    received = json.load(request.data)
    result = 0
    for i in received['data']:
        result += sum(i)
    return jsonify(result)
        

if __name__ == '__main__':
    try:
        app.run(host = '0.0.0.0',
                port = 5000,
                debug = True)
    except:
        raise

