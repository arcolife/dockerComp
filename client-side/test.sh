#!/bin/bash

curl -X POST http://$SERVER_D:5000/get_details/ -d @containers_details
curl -H "Content-type: application/son" -X POST http://$SERVER_D:5000/test/server/ -d '{"THIS IS CLIENT":"OK"}'
