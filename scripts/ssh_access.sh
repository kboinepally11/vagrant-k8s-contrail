#!/bin/sh -eux

mkdir -p /root/.ssh
touch /root/.ssh/authorized_keys
cat /home/vagrant/id_rsa.pub >> /root/.ssh/authorized_keys
