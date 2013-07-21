module VagrantPlugins
  module Sbuild
    module Action
      class DoSbuild
        def initialize(app, env)
          @app = app
          @machine = env[:machine]
          @env = env
          @dsc = File.basename(env[:dsc])
          @package = @dsc.split('_').first
          @pkg_version = @dsc.split('-').first.sub!('_','-')
        end

        def call(env)
          if @machine.communicate.ready?
            env[:ui].info("vagrant.plugins.sbuild.executing.")
            @machine.communicate.execute("sudo apt-get -y build-dep #{@package}; cd /vagrant/scratch/#{@pkg_version}; debuild -us -uc", :error_check => false) do |type, data|
              env[:ui].info(data.chomp, :prefix => false)
            end
          end
          @app.call(env)
        end
      end
    end
  end
end
