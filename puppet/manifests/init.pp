# -*- mode: ruby -*-
# vi: set ft=ruby :

include stdlib

exec { "apt_update":
  command => "apt-get -ym -qq update",
  path    => "/usr/bin"
}

exec { "apt_purge":
  command => "apt-get -y -q purge virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11",
  path => "/usr/bin",
}

$commonpkgs = [ "sbuild", "debhelper", "ubuntu-dev-tools",
                "rng-tools", "moreutils", "bzr", "apt-cacher-ng" ]

package{
  $commonpkgs: ensure => "installed"
}

exec {
  "usermod":
  command => "/usr/sbin/usermod -a -G sbuild vagrant",
  subscribe => [ Package["sbuild"] ],
}

class{'bzr::install':}
class{'rng::install':}
class{'sbuild::install':}
