#!/bin/bash

screen -p 0 -X stuff "stop^M"

while [ `ps -ef | grep java | wc -l` -eq 2 ]
do
  sleep 1
  echo "Waiting for Java to shut down"
done

sudo shutdown -h +1
exit
