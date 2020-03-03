#!/bin/bash

sudo service mongod restart
nohup node ../million/dist/app.js&
nohup node ../neon/src-express/server.js&
