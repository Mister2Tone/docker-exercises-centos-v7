# -*- mode: ruby -*-
# vi: set ft=ruby :

$install_docker = <<-SCRIPT
curl https://get.docker.com | bash
sudo usermod -aG docker vagrant
sudo systemctl start docker
sudo sysctl net.bridge.bridge-nf-call-iptables=1
sudo sysctl net.bridge.bridge-nf-call-ip6tables=1
sudo yum install epel-release jq psmisc -y
SCRIPT

Vagrant.configure("2") do |config|
    config.vm.box_check_update = false
    config.vm.synced_folder ".","/vagrant", disabled:true
    config.ssh.insert_key = false
    config.ssh.private_key_path = ["~/.vagrant.d/insecure_private_key","~/.ssh/id_rsa"]

    config.vm.define "docker-machine" do |docker|
        config.vm.box = "bento/centos-7"
        docker.vm.hostname = "docker-machine"
        docker.vm.network "private_network", ip: "192.168.56.99"
    
        docker.vm.provider "virtualbox" do |vb|
            vb.memory = "4096"
            vb.cpus = "2"
            vb.name = "docker-machine"
        end

        docker.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"

        docker.vm.provision "shell", inline: $install_docker

        docker.trigger.before :halt do |trigger|
			trigger.run_remote = { inline: "sudo systemctl stop docker" }
		end
    end
end