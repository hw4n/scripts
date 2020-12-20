#!/bin/bash

screen -p 0 -X stuff "^c"
./start.sh

# crontab -e
# 0 3 * * * /home/ubuntu/restart.sh
