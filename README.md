vagrant-sbuild
==============

spinup quick sbuild environments with additional support for custom apt repositories

## setup

+ Install virtualbox
  ```
  $ sudo apt-get install virtualbox
  ```
+ Install [vagrant][]
+ Install [vagrant-vbguest][]
  ```
  $ vagrant plugin install vagrant-vbguest
  ```
+ Set some environment variables
  ```
  export DEBEMAIL=Your Name <hi2u@mail.com>
  export DEBSIGN_KEY=123134
  ```

## usage

```
$ vagrant up
```

## create sbuild environments

```
$ vagrant ssh -- mk-sbuild saucy
```

## perform builds

```
$ vagrant ssh
$ cd path/to/**.dsc
$ sbuild -d saucy-amd64 -j4
```

## additional

Custom packages can be placed in /home/vagrant/ubuntu/repo

### reference

This vagrant project was modeled after [SbuildSimple][]. Please check there
for additional information on local packages.

## todo

+ setup vagrant multi-machine for each series
+ include a config.yaml file for setting your debian maintainer info.

[SbuildSimple]: https://wiki.ubuntu.com/SimpleSbuild
[vagrant]: http://downloads.vagrantup.com/
[vagrant-vbguest]: https://github.com/dotless-de/vagrant-vbguest
