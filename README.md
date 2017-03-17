# Steps to install vagrant based k8s cluster with contrail

##### Requirements
* Ubuntu 14.04

### Installation steps

* Update the source list and download git 
```bash
echo 'deb http://01.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse' >> /etc/apt/sources.list
echo 'deb-src http://01.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse' >> /etc/apt/sources.list
sudo apt-get update
sudo apt-get install git
```

* Clone the vagrant-k8s-contrail repository
```bash
sudo git clone https://github.com/madhukar32/vagrant-k8s-contrail.git
cd vagrant-k8s-contrail
```

* Copy the appropriate source list to the system
```bash
cp installation/ubuntu_source_list /etc/apt/sources.list
```

* Install virtualbox, vagrant, ansible and other dependent packages using bash script
```bash
./installation/install_packages.sh
```

* Copy centos vagrant_box from build server to here
```bash
scp your_user_id@10.84.5.38:/users/mnayakbomman/vagrant_box/virtualbox-centos7.box .
```

* Add base centos box to the vagrant box list
```bash
vagrant box add contrail/centos-7 virtualbox-centos7.box
```

* Generate ssh key and copy it to the shared folder
```bash
ssh-keygen -t rsa
cp -r ~/.ssh/id_rsa.pub shared/
```

* Clone or Copy contrail-ansible repo 
```bash
git clone https://github.com/Juniper/contrail-ansible
cp -r contrail-ansible/playbooks/. .

OR

scp -r your_user_id@10.84.5.38:/users/mnayakbomman/contrail-ansible/playbooks/. .
```

* Copy the sample-hosts file to inventory/my-inventory/ directory 
```bash
cp sample-hosts inventory/my-inventory/hosts
```

* Edit the inventory/my-inventory/group_vars/all.yml
    - Update the contrail_version, to the one which is available to pull from the docker registry (Check [available_contrail_container_tags](http://10.84.34.155:5000/v2/contrail-controller-u14.04/tags/list))

* Download contrail packages[This is a step to avoid known bug which will be fixed later]
```bash
set CONTRAIL_VERSION=4.0.0.0-3046 BUILD=3046;wget -P shared/packages_to_install http://10.84.5.120/github-build/mainline/${BUILD}/centos71/mitaka/artifacts/contrail-kube-cni-${CONTRAIL_VERSION}.el7.centos.x86_64.rpm
```

* Bring up the setup
```bash
vagrant up
```

* Verify the kubernetes cluster and contrail containers
```bash
vagrant ssh k8s-master1
docker ps -a | grep contrail
kubectl get nodes
kubectl get pods --all-namespaces
```

### Redeploying the cluster

* Bring down the existing cluster
```bash
vagrant destroy
```

* Make changes to your ansible or update contrail version and bring up your cluster
```bash
vagrant destroy
```
