vagrant-sbuild
==============

spinup quick sbuild environments with additional support for custom apt repositories

## Features

+ supports virtualbox and **lxc**
+ apt package caching for quicker builds
+ automatically set maxcpus available(virtualbox) to sbuild
+ supports building packages against newer/custom local packages

## Setup

+ Install virtualbox

```
$ sudo apt-get install virtualbox
```

+ Install [vagrant][]
+ Install vagrant-sbuild

```
$ git clone git://github.com:battlemidget/vagrant-sbuild.git
$ cd vagrant-sbuild
$ git submodule init
$ git submodule update
```

+ Install [vagrant-lxc][]
 
```
$ vagrant plugin install vagrant-lxc
```

+ Set some environment variables

```
export DEBEMAIL=Your Name <hi2u@mail.com>
export DEBSIGN_KEY=123134
```

### Optional

+ Install [vagrant-cachier][] for improved performance

```
$ vagrant plugin install vagrant-cachier
```

**Note**: I havent personally tested this as apt-cacher-ng is running for builds, howerver, for
the provisioning itself it may be beneficial if you are doing a lot of provisioning. Make sure
you read the __Vagrantfile__ and uncomment the section that enables the auto caching feature.

## Usage

```
$ vagrant up
```

## Create sbuild environments

```
$ vagrant mk-sbuild --series saucy
```

## Perform builds

```
$ vagrant sbuild --project saucy-amd64 --dsc scratch/PACKAGE*.dsc
```

## Additional

If packages are required that are not in the archive you may place them in
the **repo** directory and they will be included in any future builds.

### Reference

This vagrant project was modeled after [SbuildSimple][]. Please check there
for additional information [[on]] local packages.

## Todo

+ setup vagrant multi-machine for each series
+ include a config.yaml file for setting your debian maintainer info.

[SbuildSimple]: https://wiki.ubuntu.com/SimpleSbuild
[vagrant]: http://downloads.vagrantup.com/
[vagrant-lxc]: https://github.com/fgrehm/vagrant-lxc
[vagrant-cachier]: https://github.com/fgrehm/vagrant-cachier
