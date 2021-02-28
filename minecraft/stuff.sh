#!/bin/bash
  
rm screenlog*
COMMAND=`sed -e "s/[^ 0-9a-zA-Z']//g" -e 's/ \+/ /' <<< $@`
screen -p 0 -X stuff "$COMMAND^M"

while [ `cat screenlog.0 | wc -l` -lt 2 ]
do
  sleep 1
done

cat screenlog.0
