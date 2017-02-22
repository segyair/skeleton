#!/bin/bash

# ###################################
#
# This script in ran by user 'anikan'
#
# ###################################

echo "-- Installing utilities..."
./install_tasks/rvm.sh
./install_tasks/mysql.sh
./install_tasks/nginx.sh























echo
echo "************************************************"
echo
echo "Settings are done!"
echo " -- Install the rpm:"
echo "      sudo rpm -ivh greeter-0.0.1-1.x86_64.rpm"
IP=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`
echo " -- Then browse to:"
echo "      http://$IP:9192/api/v1/monitor"
echo "      http://$IP:9192/index.html"
echo
echo " -- anikan installations tasks are done."
