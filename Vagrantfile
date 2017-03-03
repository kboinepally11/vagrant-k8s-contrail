# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  (1..2).each do |id|

    controller   = "k8s-master"  + id.to_s
    controller_ip = ["10.84.29.54"]

    config.vm.define controller do |contrail_controller|
      contrail_controller.vm.box = "grtjn/centos-7.2"
      contrail_controller.vm.hostname = controller
      contrail_controller.ssh.username = 'root'
      contrail_controller.ssh.insert_key = 'true'
      contrail_controller.ssh.password = 'vagrant'

      contrail_controller.vm.network "public_network", ip: "#{controller_ip[id - 1]}", bridge: "em1"

      contrail_controller.vm.provider "virtualbox" do |vb|
        vb.memory = "16000"
        vb.cpus = 4
      end

      contrail_controller.vm.synced_folder "./shared", "/home/vagrant/"

      #shell set default gateway
       
      contrail_controller.vm.provision "shell", path: "scripts/enable_gw.sh"
      contrail_controller.vm.provision "shell", inline: "sudo route delete default gw 10.0.2.2",
        run: "always"
      contrail_controller.vm.provision "shell", path: "scripts/ssh_access.sh"
      #The below lines need to be deleted
      contrail_controller.vm.provision "shell", path: "scripts/install_kernel_repo.sh"
      contrail_controller.vm.provision "shell", path: "scripts/install_kubernetes.sh"
      contrail_controller.vm.provision "shell", path: "scripts/kube_init.sh"

    end
  end
  
  (1..2).each do |id|
    compute_ip = ["10.84.29.55", "10.84.29.56"]
    compute   = "k8s-slave"  + id.to_s
    config.vm.define compute do |contrail_compute|
      contrail_compute.vm.box = "grtjn/centos-7.2"
      contrail_compute.vm.hostname = compute
      contrail_compute.vm.synced_folder "./shared", "/home/vagrant/"

      contrail_compute.ssh.username = 'root'
      contrail_compute.ssh.password = 'vagrant'
      contrail_compute.ssh.private_key_path = './shared/id_rsa'
      
      contrail_compute.vm.network "public_network", ip: "#{compute_ip[id - 1]}", bridge: "em1"

      contrail_compute.vm.provider "virtualbox" do |vb|
        vb.memory = "16000"
        vb.cpus = 4
      end


      #shell set default gateway
      contrail_compute.vm.provision "shell", path: "scripts/install_kernel_repo.sh"
      contrail_compute.vm.provision "shell", path: "scripts/enable_gw.sh"
      contrail_compute.vm.provision "shell", inline: "sudo route delete default gw 10.0.2.2",
        run: "always"
      contrail_compute.vm.provision "shell", path: "scripts/ssh_access.sh"
      contrail_compute.vm.provision "shell", path: "scripts/install_kubernetes.sh"
      contrail_compute.vm.provision "shell", path: "scripts/kube_join.sh"
      contrail_compute.vm.provision "shell", path: "scripts/install_contrail_packages.sh"
      
      if id == 2
        contrail_compute.vm.provision :ansible do |ansible|
          ansible.verbose = "v"
          ansible.inventory_path = "inventory/my-inventory"
          ansible.playbook = "site.yml"
          ansible.limit = "all"
          ansible.sudo_user = "root"
        end
      end
    end
  end
end
