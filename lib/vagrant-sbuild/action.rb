require 'vagrant-sbuild/action/sbuild'
require 'vagrant-sbuild/action/mksbuild'

module VagrantPlugins
  module Sbuild
    module Action
      include Vagrant::Action::Builtin
      def self.do_sbuild
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use DoSbuild
        end
      end
      def self.do_mksbuild
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use DoMKSbuild
        end
      end
    end
  end
end
