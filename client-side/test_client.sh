#!/bin/bash

curl -H "Content-type: application/json" -X POST http://0.0.0.0:5000/tasks/ -d '[(1,2),(5,2),(3,5)]'
