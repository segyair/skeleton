#!/bin/bash

echo "-- Installing nginx"
sudo yum install nginx -y
sudo service nginx start
if [ `curl -sL -w "%{http_code}\\n" "http://localhost/" -o /dev/null` -ne 200 ]; then
  echo "ERROR: nginx not up"
else
  echo "nginx is up"  
fi