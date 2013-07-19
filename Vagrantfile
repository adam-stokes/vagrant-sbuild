# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Enable lxc with: vagrant plugin install vagrant-lxc
# Enable cachier with: vagrant plugin install vagrant-cachier
path = File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
$LOAD_PATH << path

Vagrant.require_plugin('vagrant-cachier')
Vagrant.require_plugin('vagrant-lxc')
Vagrant.require_plugin('vagrant-sbuild')
Vagrant.require_plugin('vagrant-salt')

Vagrant.configure("2") do |config|
  # If vagrant-cachier plugin is installed uncomment for performance improvements
  config.cache.auto_detect = true

  # LXC
  config.vm.box = "lxcprecise64v3"
  config.vm.box_url = "http://goo.gl/qiItK"

  # Networking
  # config.vm.network :hostonly, "192.168.33.10"
  # config.vm.network :bridged
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Configure where you'd like successful sbuild packages to be
  # config.vm.synced_folder "scratch", "/home/vagrant/ubuntu/scratch"
  # config.vm.synced_folder "logs", "/home/vagrant/ubuntu/logs"
  # config.vm.synced_folder "repo", "/home/vagrant/ubuntu/repo"
  config.vm.synced_folder "salt/roots", "/srv/salt/"
  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minion"
    salt.run_highstate = true
  end

end


