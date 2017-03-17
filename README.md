# Steps to install vagrant based k8s cluster with contrail

##### Requirements
* Ubuntu 14.04

### Installation steps

* Execute below lines from your command line
```bash
echo 'deb http://01.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse' >> /etc/apt/sources.list
echo 'deb-src http://01.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse' >> /etc/apt/sources.list
sudo apt-get update
sudo apt-get install git
```

* Clone the repository
```bash
sudo git clone https://github.com/madhukar32/vagrant-k8s-contrail.git
cd vagrant-k8s-contrail
```

* Copy the appropriate source repo list and update the system
```bash
cp installation/ubuntu_source_list /etc/apt/sources.list
```

* Install virtualbox, vagrant and ansible
```bash
./installation/install_packages.sh
```

* Copy vagrant_box from build server to here
```bash
scp your_user_id@10.84.5.38:/users/mnayakbomman/vagrant_box/virtualbox-centos7.box .
```

* Add vagrant box 
```bash
vagrant box add contrail/centos-7 virtualbox-centos7.box
```

* Generate ssh key and copy it to the shared folder
```bash
ssh-keygen -t rsa
cp -r ~/.ssh/id_rsa.pub shared/
```

* Copy contrail-ansible repo 
```bash
scp -r your_user_id@10.84.5.38:/users/mnayakbomman/contrail-ansible/playbooks/. .
```

* Download contrail packages[This is a bug which will be fixed later]
```bash
wget -P shared/packages_to_install http://10.84.5.120/github-build/mainline/3041/centos71/mitaka/artifacts/contrail-kube-cni-4.0.0.0-3041.el7.centos.x86_64.rpm
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
