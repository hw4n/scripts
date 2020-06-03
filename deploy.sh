#!/bin/bash

sudo service mongod restart
nohup node ../million/dist/app.js&
nohup node ../neon/src-express/server.js&

cd ../vein
sudo service mariadb start
nohup node dist/index.js&

