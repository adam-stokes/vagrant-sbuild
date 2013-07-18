module VagrantPlugins
  module Sbuild
    module Action
      class DoMKSbuild
        def initialize(app, env)
          @app = app
          @machine = env[:machine]
          @env = env
          @series = env[:series]
        end

        def call(env)
          if @machine.communicate.ready?
            env[:ui].info("vagrant.plugins.mksbuild.executing: #{@series}")
            env[:ui].info("please wait as this takes a minute.")
            @machine.communicate.execute("mk-sbuild #{@series} ", :error_check => false) do |type, data|
              env[:ui].info(data.chomp, :prefix => false)
            end
          end
          @app.call(env)
        end
      end
    end
  end
end
