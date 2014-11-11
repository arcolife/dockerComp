#!/bin/bash

curl -H "Content-type: application/json" -X POST http://104.131.170.136:49153/tasks/ -d '[(1,2),(5,2),(3,5)]'
