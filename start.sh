#!/bin/bash

lockfile="/data/lock"

if [ ! -f "$lockfile" ];then
mongod --dbpath /data/db --fork --logpath /data/log/mongodb.log &
wait $!
touch $lockfile& \
fi

redis-server &
mongod -auth --bind_ip 127.0.0.1 --port 27017 --dbpath /data/db --fork --logpath /data/log/mongodb.log &
wait $!

cd /root/PyOne
gunicorn -k eventlet -b 0.0.0.0:34567 run:app &
wait $!
