# -*- mode: ruby -*-
# vi: set ft=ruby :

class sbuild::install{

    file_line { 'schroot_mount_scratch':
      path => '/etc/schroot/sbuild/fstab',
      line => '/home/vagrant/ubuntu/scratch  /scratch   none  rw,bind  0  0',
      require => Package["sbuild"],
    }

    file_line { 'schroot_mount_repo':
      path => '/etc/schroot/sbuild/fstab',
      line => '/home/vagrant/ubuntu/repo     /repo      none  ro,bind  0  0',
      require => Package["sbuild"],
    }

    file {
      '/etc/schroot/script-get-ddebs':
      owner => 'root',
      group => 'root',
      mode => 744,
      content => template('sbuild/script-get-ddebs.erb'),
      require => Package["sbuild"],
    }


    file {
      '/home/vagrant/.sbuildrc':
      owner => 'vagrant',
      group => 'vagrant',
      mode => 644,
      content => template('sbuild/sbuildrc.erb'),
      require => Package["sbuild"],
      notify => File['/home/vagrant/.devscripts'],
    }

    file {
      '/home/vagrant/.mk-sbuild.rc':
      owner => 'vagrant',
      group => 'vagrant',
      mode => 644,
      content => template('sbuild/mk-sbuild.rc.erb'),
      require => Package["sbuild"],
    }

    file {
      '/home/vagrant/.devscripts':
      owner => 'vagrant',
      group => 'vagrant',
      mode => 644,
      content => template('sbuild/devscripts.erb'),
    }

    file {
      [ '/home/vagrant/ubuntu', '/home/vagrant/ubuntu/logs' ]:
      ensure => 'directory',
      owner => "vagrant",
      group => "vagrant",
      mode => 750,
    }

    exec {
      "sbuild-keyring":
      command => "/usr/bin/sbuild-update --keygen >> /dev/null",
      subscribe => [ Package["sbuild"], Package["rng-tools"] ],
    }

}
