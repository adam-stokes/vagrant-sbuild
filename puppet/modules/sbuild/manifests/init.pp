include stdlib
class sbuild::install{
    $commonpkgs = [ "sbuild", "debhelper", "ubuntu-dev-tools", "rng-tools", "moreutils", "bzr" ]
    package{ $commonpkgs: ensure => "installed" }

    file_line { 'schroot_mount_scratch':
      path => '/etc/schroot/sbuild/fstab',
      line => '/home/vagrant/ubuntu/scratch  /scratch          none  rw,bind  0  0',
      require => Package["sbuild"],
    }

    file_line { 'schroot_mount_repo':
      path => '/etc/schroot/sbuild/fstab',
      line => '/home/vagrant/ubuntu/repo     /repo             none  ro,bind  0  0',
      require => Package["sbuild"],
    }

    file {
      '/etc/default/rng-tools':
      owner => 'root',
      group => 'root',
      ensure => file,
      mode => 644,
      source => '/vagrant/files/default/rng-tools',
      require => Package["rng-tools"],
      notify => Service["rng-tools"],
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
      [ '/home/vagrant/ubuntu', '/home/vagrant/ubuntu/logs' ]:
      ensure => 'directory',
      owner => "vagrant",
      group => "vagrant",
      mode => 750,
    }

    exec {
      "usermod":
      command => "/usr/sbin/usermod -a -G sbuild vagrant",
      subscribe => [ Package["sbuild"] ],
      path => ["/usr/bin", "/usr/sbin", "/bin"],
    }

    exec {
      "sbuild-keyring":
      command => "bash -c 'perl /usr/bin/sbuild-update --keygen'",
      subscribe => [ Package["sbuild"] ],
      path => ["/usr/bin", "/usr/sbin", "/bin"],
    }

    exec {
      "bzrrepotools":
      command => "bash -c 'bzr branch lp:~barry/+junk/repotools /home/vagrant/ubuntu/repo'",
      path => ["/usr/bin", "/bin"],
      subscribe => [ Package["bzr"], File['/home/vagrant/ubuntu' ] ],
    }

    service { "rng-tools":
      ensure => "running",
      enable => "true",
      require => Package["rng-tools"],
    }
}
