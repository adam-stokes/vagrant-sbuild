# -*- mode: ruby -*-
# vi: set ft=ruby :

class bzr::install {

    file {
      [ '/home/vagrant/.bazaar' ]:
      ensure => 'directory',
      owner => "vagrant",
      group => "vagrant",
      mode => 750,
    }

    file {
      '/home/vagrant/.bazaar/bazaar.conf':
      owner => 'vagrant',
      group => 'vagrant',
      mode => 644,
      content => template('bzr/bazaar.conf.erb'),
      require => File['/home/vagrant/.bazaar'],
    }
}
