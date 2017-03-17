#!/bin/sh -eux
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get install -y gcc make
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
echo 'deb http://download.virtualbox.org/virtualbox/debian trusty contrib' >> /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y virtualbox-5.1
sudo apt-get install -y dkms
wget -O /var/tmp/vagrant.deb https://releases.hashicorp.com/vagrant/1.9.2/vagrant_1.9.2_x86_64.deb?_ga=1.163248889.497768144.1486428822
dpkg -i /var/tmp/vagrant.deb 

sudo apt-get install -y python-pip
sudo apt-get install python-dev
sudo pip install ansible==2.2.1.0
easy_install markupsafe
