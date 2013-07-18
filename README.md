vagrant-sbuild
==============

spinup quick sbuild environments with additional support for custom apt repositories

## features

+ apt package caching for quicker builds
+ automatically set maxcpus available to sbuild
+ supports building packages against newer/custom local packages

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

+ Install vagrant-sbuild

```
$ git clone git://github.com:battlemidget/vagrant-sbuild.git
$ cd vagrant-sbuild
$ git submodule init
$ git submodule update
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
$ vagrant mk-sbuild --series saucy
```

## perform builds

```
$ vagrant sbuild --project saucy-amd64 --dsc scratch/PACKAGE*.dsc
```

## additional

If packages are required that are not in the archive you may place them in
the **repo** directory and they will be included in any future builds.

### reference

This vagrant project was modeled after [SbuildSimple][]. Please check there
for additional information [[on]] local packages.

## todo

+ setup vagrant multi-machine for each series
+ include a config.yaml file for setting your debian maintainer info.
+ extend vagrant commands to include mk-sbuild.

[SbuildSimple]: https://wiki.ubuntu.com/SimpleSbuild
[vagrant]: http://downloads.vagrantup.com/
[vagrant-vbguest]: https://github.com/dotless-de/vagrant-vbguest
