#!/bin/bash

curl -H "Content-type: application/json" -X POST http://104.131.170.133:5000/test/server/ -d '{"THIS IS CLIENT":"OK"}'
curl -H "Content-type: application/json" -X POST http://104.131.170.133:5000/get_details/ -d @container_info.json
