#!/usr/bin/python

import ast#, json
import os, sys
from flask import Flask, jsonify, request, Response

app = Flask(__name__, static_url_path='')


@app.route('/', methods=['GET'])
def home():
    return jsonify({'client_test': 'OK'})


@app.route('/test/client/', methods=['POST'])
def test():
    print request.data
    return jsonify({'got response from server': 'OK'})

@app.route('/tasks/', methods=['POST'])
def get_tasks():
    received = ast.literal_eval(request.data)
    #print received[0]
    result = 0
    for i in received:
        result += sum(i)
    return Response(str(result))

if __name__ == '__main__':
    try:
        app.run(host = '0.0.0.0',
                #port = 5001,
                debug = False)
    except:
        raise

