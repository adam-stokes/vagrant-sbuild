# -*- mode: ruby -*-
# vi: set ft=ruby :

include stdlib

exec { "apt_update":
  command => "apt-get -ym -qq update",
  path    => "/usr/bin"
}

$commonpkgs = [ "sbuild", "debhelper", "ubuntu-dev-tools",
                "rng-tools", "moreutils", "bzr" ]

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
