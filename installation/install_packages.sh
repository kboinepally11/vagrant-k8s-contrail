#!/bin/sh -eux
sudo apt-get update

#####Install dependencies

sudo apt-get install -y python-pip
sudo apt-get install -y python-dev
sudo apt-get install -y libffi-dev
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test 
sudo apt-get install -y gcc make

#####Download and install virtualbox 
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
echo 'deb http://download.virtualbox.org/virtualbox/debian trusty contrib' >> /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y virtualbox-5.1
sudo apt-get install -y dkms

#####Download and install vagrant
wget -O /var/tmp/vagrant.deb https://releases.hashicorp.com/vagrant/1.9.2/vagrant_1.9.2_x86_64.deb?_ga=1.163248889.497768144.1486428822
dpkg -i /var/tmp/vagrant.deb 

#####Install ansible
sudo pip install ansible==2.2.1.0
easy_install markupsafe
