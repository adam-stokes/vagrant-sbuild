vagrant-sbuild
==============

spinup quick sbuild environments with additional support for custom apt repositories

## Features

+ supports virtualbox and **lxc**
+ apt package caching for quicker builds
+ automatically set maxcpus available(virtualbox) to sbuild
+ supports building packages against newer/custom local packages

## Setup

+ Install lxc

```
$ sudo apt-get install lxc apt-cacher-ng
```

+ Install [vagrant][]
+ Install vagrant-sbuild

```
$ git clone git://github.com:battlemidget/vagrant-sbuild.git
$ cd vagrant-sbuild
```

+ Install [vundler][]
 
```
$ vagrant plugin install vundler
```

+ Install vagrant bundle (for fetching plugin dependencies)

```
$ vagrant plugin bundle
```

+ Set some environment variables

```
export DEBEMAIL=Your Name <hi2u@mail.com>
export DEBSIGN_KEY=123134
```

## Usage

```
$ vagrant up [saucy|raring|quantal|precise]
```

## Perform builds

```
$ vagrant sbuild [series] --dsc scratch/PACKAGE*.dsc
```

Built packages will be in your **scratch** directory.

## Additional

If packages are required that are not in the archive you may place them in
the **repo** directory and they will be included in any future builds.

### Reference

This vagrant project was modeled after [SbuildSimple][]. Please check there
for additional information on local packages.

## Todo

+ setup vagrant multi-machine for each series
+ include a config.yaml file for setting your debian maintainer info.

[SbuildSimple]: https://wiki.ubuntu.com/SimpleSbuild
[vagrant]: http://downloads.vagrantup.com/
[vundler]: https://github.com/fgrehm/vundler


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/battlemidget/vagrant-sbuild/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

