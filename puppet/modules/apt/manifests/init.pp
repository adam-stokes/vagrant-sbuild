# -*- mode: ruby -*-
# vi: set ft=ruby :

class apt::install {
    file {
      '/etc/apt/sources.list':
      owner => 'root',
      group => 'root',
      mode => 644,
      content => template('apt/sources.list.erb'),
    }

    $commonpkgs = [
      "sbuild",
      "debhelper",
      "ubuntu-dev-tools",
      "build-essential",
      "moreutils",
      "bzr",
      "apt-cacher-ng"
    ]

    package {
      $commonpkgs: ensure => "installed"
    }

    exec { "apt_update":
      command => "apt-get -ym -qq update",
      path    => "/usr/bin",
      subscribe => File['/etc/apt/sources.list']
    }

    # exec { "apt_dist_upgrade":
    #  command => "apt-get -ym -qq dist-upgrade",
    #  path => "/usr/bin",
    # }
}
