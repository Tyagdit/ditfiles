# -*- mode: ruby -*-
# vi: set ft=ruby :

# This file is hyper-specific to my current system with Hyper-V on Win10+WSL and
# a pre-configured virtual switch in Hyper-V running on an AMD processor
# There are some network issues and synced folders don't work
# Keeping it in this repo just for reference
Vagrant.configure("2") do |config|

  config.vm.define "machine_fedora34" do |machine|

    machine.vm.box = "generic/fedora34"
    machine.vm.provider "hyperv"

    # Networking is weird with Hyper-V
    machine.vm.network "public_network", bridge: "External switch"

    # Uses SMBv1 which is disabled on windows, also has issues with WSL
    machine.vm.synced_folder ".", "/vagrant_data", disabled: true
    
    machine.vm.provider "hyperv" do |hyperv|
      # Unavailable on AMD processors
      hyperv.enable_virtualization_extensions = false
      hyperv.linked_clone = true
      hyperv.vmname = "fedora34"
    end

    $script = <<-'EOF'
      python3 -m pip install --user ansible
      git clone --branch ansible https://github.com/tyagdit/ditfiles /home/vagrant/ditfiles
      cd /home/vagrant/ditfiles
      printf "install_node: yes\ninstall_docker: no\n" > vars/vars.yml
       ansible-playbook playbook.yml -e "ansible_become_pass=vagrant" # leading space is needed
    EOF
    machine.vm.provision "shell" do |sh|
      sh.inline = $script
      sh.privileged = false
    end

  end
end
