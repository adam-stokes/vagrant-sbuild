# -*- mode: ruby -*-
# vi: set ft=ruby :

# rng-tools for entropy when generating keys
class rng::install {
    file {
      '/etc/default/rng-tools':
      owner => 'root',
      group => 'root',
      ensure => file,
      mode => 644,
      content => template('rng/rng-tools.erb'),
      require => Package["rng-tools"],
      notify => Service["rng-tools"],
    }

    service { "rng-tools":
      ensure => "running",
      enable => "true",
      require => Package["rng-tools"],
    }
}
