#!/bin/bash

rm screenlog*
screen -p 0 -X stuff "list^M"

while [ `cat screenlog.0 | wc -l` -lt 3 ]
do
  sleep 1
done

cat screenlog.0 | sed -n 2,3p
