module VagrantPlugins
  module Sbuild
    module Action
      class DoSbuild
        def initialize(app, env)
          @app = app
          @machine = env[:machine]
          @env = env
          @project = env[:project]
          @dsc = File.basename(env[:dsc])
        end

        def call(env)
          if @machine.communicate.ready?
            env[:ui].info("vagrant.plugins.sbuild.executing.")
            @machine.communicate.execute("cd ubuntu/scratch; sbuild -v -A -d #{@project} -j4 #{@dsc}", :error_check => false) do |type, data|
              env[:ui].info(data.chomp, :prefix => false)
            end
          end
          @app.call(env)
        end
      end
    end
  end
end
