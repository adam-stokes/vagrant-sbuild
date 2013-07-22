# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-sbuild/version'

Gem::Specification.new do |spec|
  spec.name = "vagrant-sbuild"
  spec.version = VagrantPlugins::Sbuild::VERSION
  spec.authors = ["Adam Stokes"]
  spec.email = ["adam.stokes@ubuntu.com"]
  spec.description = %q{Automate package building}
  spec.summary = spec.description
  spec.homepage = "https://github.com/battlemidget/vagrant-sbuild"
  spec.license = "GPLv3+"

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end
