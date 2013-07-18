# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"
  config.vm.box_url = "http://goo.gl/xZ19a"

  # config.vm.network :hostonly, "192.168.33.10"
  # config.vm.network :bridged
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Experimental: (aka doesnt work yet)
  # Configure where you'd like successful sbuild packages to be
  # config.vm.share_folder "builds", "/vagrant_builds", ENV['HOME']. "/builds"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file  = "init.pp"
    puppet.options="--debug"
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
