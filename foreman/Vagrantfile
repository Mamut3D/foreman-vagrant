# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  config.vm.box = 'bento/centos-7.4'
  config.vm.provider("virtualbox") { |v| v.linked_clone = true }
  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.provision "puppet"
  # Puppet-master
  config.vm.define "pm" do |cfg|
    cfg.vm.provider("virtualbox") { |v| v.customize ["modifyvm", :id, "--memory", "4096", "--cpus", "2"] }
    cfg.vm.hostname = "pm.local"
    cfg.vm.network "private_network", ip: "10.55.55.3"
    cfg.vm.provision "shell",
      inline: "/opt/puppetlabs/puppet/bin/puppet module install puppetlabs-inifile"
    cfg.vm.provision(:puppet) { |p| p.manifest_file = "pm-setup.pp" }
  end

  # Foreman-machine
  config.vm.define "fm", primary: true do |cfg|
    cfg.vm.provider("virtualbox") { |v| v.customize ["modifyvm", :id, "--memory", "2048", "--cpus", "2"] }
    cfg.vm.hostname = "fm.local"
    cfg.vm.network "private_network", ip: "10.55.55.2"
    cfg.vm.provision :shell, path: "fm/install.sh"
    cfg.vm.provision :shell, path: "fm/config.sh"
    cfg.vm.post_up_message = "Foreman is accesible at https://10.55.55.2/users/login"
  end
end
