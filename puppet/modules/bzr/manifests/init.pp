# -*- mode: ruby -*-
# vi: set ft=ruby :

include vcsrepo

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

    vcsrepo { "/home/vagrant/ubuntu/repo":
      ensure   => present,
      provider => bzr,
      source   => 'lp:~debugmonkeys/+junk/repotools',
      subscribe => [ Package["bzr"], File['/home/vagrant/ubuntu'] ],
    }

}
