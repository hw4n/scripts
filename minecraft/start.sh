#!/bin/bash

# minecraft/start.sh only contains command like following
# java -server -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -Xmx6144M -Xms4096M -jar forge-1.16.4-35.1.13.jar nogui

screen -dm -L -S minecraft bash -c "cd minecraft; ./start.sh"

# also crontab -e and add following
# @reboot /home/ubuntu/start.sh
