#!/bin/bash

cd i-ignore-robot-txt-and-scrape/
screen -dm bash -c "node index.js"

# crontab -e
# @reboot /home/ubuntu/start.sh
