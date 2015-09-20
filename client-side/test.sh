#!/bin/bash

curl -H "Content-type: application/json" -X POST http://$DC_HOST:$DC_PORT/test/server/ -d '{"THIS IS CLIENT":"OK"}'
#curl -H "Content-type: application/json" -X POST http://$1:5000/get_details/ -d @container_info.json
