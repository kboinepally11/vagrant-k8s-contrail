#!/bin/sh -eux

touch /home/vagrant/kubeadm_init_output
kubeadm init > /home/vagrant/kubeadm_init_output

