#!/bin/bash

curl -X POST http://104.131.170.133:5000/get_details/ -d @containers_details
curl -H "Content-type: application/json" -X POST http://104.131.170.133:5000/test/server/ -d '{"THIS IS CLIENT":"OK"}'
