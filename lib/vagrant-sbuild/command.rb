require 'optparse'

module VagrantPlugins
  module Sbuild
      class CommandSbuild < Vagrant.plugin("2", :command)
        def execute
          options = {}
          opts = OptionParser.new do |o|
            o.banner = "Usage: vagrant sbuild [vm-name] [--dsc PACKAGE*.dsc]"
            o.separator ''
            o.version = VagrantPlugins::Sbuild::VERSION
            o.program_name = 'vagrant sbuild'

            o.on("--dsc file", String, "The .dsc file you wish to build") do |dsc|
              options[:dsc] = dsc
            end
          end

          # Parse the options and return if we don't have any target.
          argv = parse_options(opts)
          return if !argv

          # Execute the actual build
          with_target_vms(argv, options) do |vm|
            @env.action_runner.run(Action.do_sbuild, {
              :machine => vm,
              :dsc => options[:dsc],
            })
          end
        end
      end
    end
  end
