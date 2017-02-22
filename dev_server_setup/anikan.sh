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
./install_tasks/rpm.sh

echo "-- Setting environment for building rpms..."
mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros

echo "-- Setting dev and rpm working environments..."
mkdir -p /home/anikan/dev/tutorial/greeter/
mv code /home/anikan/dev/tutorial/greeter/
mv rpm_builder /home/anikan/dev/tutorial/greeter/

echo "-- Setting nginx environments..."
mkdir -p /home/anikan/dev/tutorial/greeter/code/home/anikan/greeter/shared/{logs,config,nginx/logs}
sudo /usr/sbin/nginx -p /home/anikan/dev/tutorial/greeter/code/home/anikan/greeter/shared/nginx -c /home/anikan/dev/tutorial/greeter/code/home/anikan/greeter/current/build/nginx/nginx_dev.conf
# use -t flag to varify config file
sudo service nginx restart

# these two are needed for installing bundle with this scripy. need further investigation.
sudo yum install ruby-devel -y
gem install io-console

gem install bundle

cd /home/anikan/dev/tutorial/greeter/code/home/anikan/greeter/current
bundle install
bundle exec ruby build/scripts/create_db.rb
rake db:migrate
cd

echo
echo "************************************************"
echo
echo "Settings are done!"
echo " -- Start greeter app with:"
echo "      /home/anikan/dev/tutorial/greeter/code/home/anikan/greeter/current/bin/greeter"
IP=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`
echo " -- Then browse to:"
echo "      http://$IP:9192/api/v1/monitor"
echo "      http://$IP:9192/index.html"
echo
echo " -- Creating the rpm:"
echo "      ruby /home/anikan/dev/tutorial/greeter/rpm_builder/create_rpm.rb"
echo
echo " -- anikan installations tasks are done."
echo
