# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  (1..1).each do |id|

    controller   = "k8s-master"  + id.to_s
    controller_private_ip = ["192.168.50.4"]
    #If public IP, give a list of public IP's for your master VM
    #controller_public_ip = []

    config.vm.define controller do |contrail_controller|
      contrail_controller.vm.box = "contrail/centos-7"
      contrail_controller.vm.hostname = controller
      contrail_controller.vm.synced_folder "./shared", "/home/vagrant/"

      contrail_controller.ssh.username = 'root'
      contrail_controller.ssh.insert_key = 'true'
      contrail_controller.ssh.password = 'c0ntrail123'

      #Private network
      contrail_controller.vm.network "private_network", ip: "#{controller_private_ip[id - 1]}"

      #Public Network
      ###If public network uncomment the below lines and define varaible controller_public_ip, change the bridge interface according to your host
      #contrail_controller.vm.network "public_network", ip: "#{controller_public_ip[id - 1]}", bridge: "em1"
      ####Please change the default gw according to your setup
      #contrail_controller.vm.provision "shell", inline: "sudo route add default gw 10.87.65.254",
      #  run: "always"
      #contrail_controller.vm.provision "shell", inline: "sudo route delete default gw 10.0.2.2",
      #  run: "always"

      #Forwarded ports
      contrail_controller.vm.network "forwarded_port", guest: 22, host: 2300
      contrail_controller.vm.network "forwarded_port", guest: 8085, host: 8085
      contrail_controller.vm.network "forwarded_port", guest: 8082, host: 8082

      contrail_controller.vm.provider "virtualbox" do |vb|
        vb.memory = "16000"
        vb.cpus = 4
      end

      contrail_controller.vm.synced_folder "./shared", "/home/vagrant/"

       
      #The below lines need to be deleted
      contrail_controller.vm.provision "shell", path: "scripts/ssh_access.sh"
      contrail_controller.vm.provision "shell", path: "scripts/install_kubernetes.sh"
      contrail_controller.vm.provision "shell", path: "scripts/kube_init.sh"

    end
  end
  
  (1..2).each do |id|
    compute_private_ip = ["192.168.50.5", "192.168.50.6"]
    #If public IP, give a list of public IP's for your master VM
    #compute_public_ip = []

    compute   = "k8s-slave"  + id.to_s
    config.vm.define compute do |contrail_compute|
      contrail_compute.vm.box = "contrail/centos-7"
      contrail_compute.vm.hostname = compute
      contrail_compute.vm.synced_folder "./shared", "/home/vagrant/"

      contrail_compute.ssh.username = 'root'
      contrail_compute.ssh.insert_key = 'true'
      contrail_compute.ssh.password = 'c0ntrail123'
     
      #Private Network 
      contrail_compute.vm.network "private_network", ip: "#{compute_private_ip[id - 1]}"

      #Public Network
      ###If public network uncomment the below lines and define varaible compute_public_ip, change the bridge interface according to your host
      #contrail_compute.vm.network "public_network", ip: "#{compute_public_ip[id - 1]}", bridge: "em1"
      ####Please change the default gw according to your setup
      #contrail_compute.vm.provision "shell", inline: "sudo route add default gw 10.87.65.254",
      #  run: "always"
      #contrail_compute.vm.provision "shell", inline: "sudo route delete default gw 10.0.2.2",
      #  run: "always"

      if id == 1
        contrail_compute.vm.network "forwarded_port", guest: 22, host: 2301
      end

      if id == 2
        contrail_compute.vm.network "forwarded_port", guest: 22, host: 2302
      end

      contrail_compute.vm.provider "virtualbox" do |vb|
        vb.memory = "16000"
        vb.cpus = 4
      end


      #shell set default gateway
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
          ansible.raw_arguments  = ["--private-key=/root/.ssh/id_rsa"]
        end
      end
    end
  end
end
