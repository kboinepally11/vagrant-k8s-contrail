#!/bin/sh -eux

kube_join=$(awk '/./{line=$0} END{print line}' /home/vagrant/kubeadm_init_output)
echo $kube_join
$kube_join
