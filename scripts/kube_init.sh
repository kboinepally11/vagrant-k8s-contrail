#!/bin/sh -eux

touch /home/vagrant/kubeadm_init_output
kubeadm init --api-advertise-addresses 192.168.50.4 > /home/vagrant/kubeadm_init_output

