#!/bin/sh -eux

sudo su - root
echo "GATEWAY=10.84.29.254" >> /etc/sysconfig/network-scripts/ifcfg-eth1
sudo ifup eth1
