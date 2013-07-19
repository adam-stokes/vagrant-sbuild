# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# Enable guestadditions with: vagrant plugin install vagrant-vbguest
# Enable lxc with: vagrant plugin install vagrant-lxc
#
# To CHANGE the golden image: sudo schroot -c precise-amd64-source -u root
# To ENTER an image snapshot: schroot -c precise-amd64
# To BUILD within a snapshot: sbuild -A -d precise-amd64 PACKAGE*.dsc
path = File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
$LOAD_PATH << path

Vagrant.require_plugin('vagrant-sbuild')

Vagrant.configure("2") do |config|
  # Set to true if you wish to have GuestAdditions updated for cloud image
  config.vbguest.auto_update = false

  # Every Vagrant virtual environment requires a box to build off of.
  # VirtualBox
  config.vm.box = "precise64"
  config.vm.box_url = "http://goo.gl/xZ19a"

  # config.vm.network :hostonly, "192.168.33.10"
  # config.vm.network :bridged
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Experimental: (aka doesnt work yet)
  # Configure where you'd like successful sbuild packages to be
  config.vm.synced_folder "scratch", "/home/vagrant/ubuntu/scratch"
  # Share logs and repo from host machine so you can easily get to the
  # builds done on the vagrant box
  config.vm.synced_folder "logs", "/home/vagrant/ubuntu/logs"
  config.vm.synced_folder "repo", "/home/vagrant/ubuntu/repo"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file  = "init.pp"
    # Uncomment for extended information
    # puppet.options="--verbose --debug"
    puppet.facter = {
      "debemail" => ENV['DEBEMAIL'] || "Rod Piper <wwf@4life.com>",
      "debsign_key" => ENV['DEBSIGN_KEYID'] || "123456",
    }
   end

  # Configure max cpus
  config.vm.provider :virtualbox do |vb|
     vb.customize ["modifyvm", :id, "--cpus",
      `awk "/^processor/ {++n} END {print n}" /proc/cpuinfo 2> /dev/null || sh -c 'sysctl hw.logicalcpu 2> /dev/null || echo ": 2"' | awk \'{print \$2}\' `.chomp ]
  end
end


