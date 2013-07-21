require 'vagrant-sbuild/action/sbuild'

module VagrantPlugins
  module Sbuild
    module Action
      include Vagrant::Action::Builtin
      def self.do_sbuild
        Vagrant::Action::Builder.new.tap do |builder|
          builder.use DoSbuild
        end
      end
   end
  end
end
