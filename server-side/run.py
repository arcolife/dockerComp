#!/usr/bin/python
# -*- coding: utf-8 -*-

##############
# dockerComp #
##############

from app import app
from flask import \
    Flask, \
    render_template

from config import \
    HOST, \
    PORT, \
    DEBUG,\
    TEMPLATE_CONFIGURATION


@app.route('/')
def home():
    """
    dockerComp Container Management dashboard
    """
    return render_template('index.html',
                           **TEMPLATE_CONFIGURATION)


if __name__ == '__main__':
    try:
        app.run(host = HOST,
                port = PORT,
                debug = DEBUG)
    except:
        raise
