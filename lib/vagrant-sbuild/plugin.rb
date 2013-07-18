require "vagrant-sbuild/action"

module VagrantPlugins
  module Sbuild
    class Plugin < Vagrant.plugin("2")
      name "Sbuild"
      description <<-DESC
        This plugins provides facilities for sbuild
      DESC

      command(:sbuild) do
        require_relative "command"
        CommandSbuild
      end

      command("mk-sbuild") do
        require_relative "command"
        CommandMKSbuild
      end
    end
  end
end
