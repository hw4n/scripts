#!/bin/bash
  
# set screen session's name
# start screen in detached mode and execute bash command

screen -S api.sdvx.org -dm bash -c "cd sdvx-music-api; node dist/index.js"
screen -S vhb -dm bash -c "cd vhb; node index.js"
