#!/bin/bash

echo "-- Instal tools for building RPMs"
sudo yum install rpm-build -y
if [[ $(rpmbuild --version) =~ "RPM version" ]]; then
  echo "rpmbuild is installed: `rpmbuild --version`"  
else
  echo "ERROR: problem with rpmbuild installation (checked 'rpmbuild --version': $(rpmbuild --version))"
fi

sudo yum install redhat-rpm-config -y