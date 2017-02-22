#!/bin/bash

echo "-- Installing rvm"
gpg --keyserver hkp://keys.gnupg.net --recv-keys  409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --ruby
echo 'source ~/.profile' >> /home/`whoami`/.bash_profile
source /home/`whoami`/.rvm/scripts/rvm
if [[ $(rvm -v) =~ "https://rvm.io/" ]]; then
  echo "rvm is installed: `rvm -v`"  
else
  echo "ERROR: problem with rvm installation (checked 'rvm -v': $(rvm -v))"
fi