include stdlib
class sbuild::install{
    $commonpkgs = [ "sbuild", "debhelper", "ubuntu-dev-tools" ]
    package{ $commonpkgs: ensure => "installed" }

    exec { "adduser":
      command => "adduser vagrant sbuild",
      path => "/usr/sbin"
    }

    file_line { 'schroot_mount':
      path => '/etc/schroot/sbuild/fstab',
      line => '/home/vagrant/ubuntu/scratch  /scratch          none  rw,bind  0  0',
    }

    file {
      '/home/vagrant/.sbuildrc':
      owner => 'vagrant',
      group => 'vagrant',
      ensure => file,
      mode => 644,
      source => '/vagrant/files/sbuildrc',
      require => Package["sbuild"],
    }

    file {
      '/home/vagrant/.mk-sbuild.rc':
      owner => 'vagrant',
      group => 'vagrant',
      ensure => file,
      mode => 644,
      source => '/vagrant/files/mk-sbuild.rc',
      require => Package["sbuild"],
    }

    file {
      '/home/vagrant/ubuntu/logs':
      ensure => 'directory',
      owner => "vagrant",
      group => "vagrant",
      mode => 750,
    }
}
