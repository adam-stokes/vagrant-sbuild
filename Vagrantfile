# -*- mode: ruby -*-
# vi: set ft=ruby :
#

begin
  # For local libs, temporary until this plugin is matured.
  path = File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
  $LOAD_PATH << path
end
begin
  require 'vundler'
rescue LoadError; end

BASE_URL          = 'https://dl.dropboxusercontent.com/u/9578000'
LAST_RELEASE_DATE = '2013-07-20'

def lxc_box_url(release_name)
  file_name      = "lxc-#{release_name}-amd64-#{LAST_RELEASE_DATE}.box"
  "#{BASE_URL}/#{file_name}"
end

BOXES = {
  precise: {
    lxc_url:  lxc_box_url('precise'),
  },
  quantal: {
    lxc_url:  lxc_box_url('quantal'),
  },
  raring:  {
    lxc_url:  lxc_box_url('raring'),
  },
  saucy: {
    lxc_url: lxc_box_url('saucy'),
  }
}

Vagrant.configure("2") do |config|
  config.cache.scope = :machine
  config.cache.auto_detect = true

  config.vm.synced_folder "salt/roots", "/srv"

  config.ssh.timeout = 300
  config.ssh.max_tries = 300

  BOXES.each do |box_name, box_config|
    config.vm.define(box_name.to_sym) do |vm_config|
      vm_config.vm.box = "#{box_name}64"
      vm_config.vm.network :forwarded_port, guest: 80, host: 8080

      vm_config.vm.provider :lxc do |lxc, lxc_config|
        lxc_config.vm.box_url = box_config[:lxc_url]
        lxc_config.vm.hostname = "#{box_name}-lxc-dev-salt"
        lxc.customize "aa_profile", "unconfined"
      end

      vm_config.vm.provision :salt do |salt|
        salt.minion_config = "salt/minion"
        salt.run_highstate = true
      end
    end
  end
end
