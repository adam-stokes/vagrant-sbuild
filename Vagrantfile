# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Enable lxc with: vagrant plugin install vagrant-lxc
# Enable cachier with: vagrant plugin install vagrant-cachier
path = File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
$LOAD_PATH << path

Vagrant.require_plugin('vagrant-cachier')
#Vagrant.require_plugin('vagrant-lxc')
#Vagrant.require_plugin('vagrant-sbuild')
Vagrant.require_plugin('vagrant-salt')

Vagrant.configure("2") do |config|
  # If vagrant-cachier plugin is installed uncomment for performance improvements
  config.cache.auto_detect = true
  config.vm.define :salt do |salt_config|
    # Every Vagrant virtual environment requires a box to build off of.
    # VirtualBox
    salt_config.vm.box = "precise64"
    salt_config.vm.box_url = "http://goo.gl/xZ19a"
    salt_config.vm.network :forwarded_port, guest: 80, host: 8080
    salt_config.ssh.timeout = 300
    salt_config.ssh.max_tries = 300
    salt_config.vm.synced_folder "salt/roots", "/srv/salt/"
    salt_config.vm.provision :salt do |salt|
      salt.minion_config = "salt/minion"
      salt.run_highstate = true
    end
  end
end
