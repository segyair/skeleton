#!/bin/bash

sudo yum update -y

sudo adduser anikan
sudo bash -c 'echo "%anikan  ALL = (ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)'

sudo mkdir /home/anikan/install_tasks
sudo cp -r install_tasks/* /home/anikan/install_tasks/
sudo chmod -R +x /home/anikan/install_tasks


sudo mv greeter*.rpm /home/anikan/
sudo mv anikan.sh /home/anikan/

sudo chown -R anikan:anikan /home/anikan

echo
echo " -- 'anikan' user created"
echo " -- Change user to 'anikan':"
echo "      sudo su - anikan"
echo " -- Then execute:"
echo "      ./anikan.sh"
echo
