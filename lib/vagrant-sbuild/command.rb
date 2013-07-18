require 'optparse'

module VagrantPlugins
  module Sbuild
      class CommandSbuild < Vagrant.plugin("2", :command)
        def execute
          options = {}
          opts = OptionParser.new do |o|
            o.banner = "Usage: vagrant sbuild [vm-name] [-p project] [--dsc PACKAGE*.dsc]"
            o.separator ''
            o.version = VagrantPlugins::Sbuild::VERSION
            o.program_name = 'vagrant sbuild'

            o.on("--project project", String,
                 "Selects an sbuild environment, e.g. precise-amd64") do |project|
              options[:project] = project
            end

            o.on("--dsc file", String, "The .dsc file you wish to build") do |dsc|
              options[:dsc] = dsc
            end
          end

          # Parse the options and return if we don't have any target.
          argv = parse_options(opts)

          # Execute the actual build
          with_target_vms(argv, options) do |vm|
            @env.action_runner.run(Action.do_sbuild, {
              :machine => vm,
              :project => options[:project],
              :dsc => options[:dsc],
            })
          end
        end
      end

      class CommandMKSbuild < Vagrant.plugin("2", :command)
        def execute
          options = {}
          opts = OptionParser.new do |o|
            o.banner = "Usage: vagrant mk-sbuild [vm-name] [--series SERIES]"
            o.separator ''
            o.version = VagrantPlugins::Sbuild::VERSION
            o.program_name = 'vagrant mk-sbuild'

            o.on("--series SERIES", String,
                 "Builds a schroot for series, e.g. precise|quantal|raring|saucy") do |series|
              options[:series] = series
            end
          end

          # Parse the options and return if we don't have any target.
          argv = parse_options(opts)

          # Execute the actual build
          with_target_vms(argv, options) do |vm|
            @env.action_runner.run(Action.do_mksbuild, {
              :machine => vm,
              :series => options[:series],
            })
          end
        end
      end

    end
  end
