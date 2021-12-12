require_relative 'np_service.rb'

class NpNodeService < NpService

  def initialize(**args)
    super(**args)
  end

  def prepare_service
    prepare_local_service if on_local_kraken?
  end

  def prepare_local_service
    
  end

  def start_command
    'npmstartservice'
  end


# elsif np_service.on_local_convox?
#   # create the app if it does not exist
#   create_convox_app(convox_app) if convox_app_path_exists?(convox_app) && opts_wait_convox && !ConvoxUtil.convox_app_exists?(convox_app, use_cache: true)

#   app_command = 
# elsif np_service.on_local_kraken?

#   if np_service.type_is_node?
#     exec_command "np-service-prepare -a #{app}" unless convox_app_path_exists?(convox_app)
#     app_command = 'npmstartservice'
#   elsif np_service.type_is_ruby?
#     exec_command "np-service-prepare -a #{app}" unless convox_app_path_exists?(convox_app)
#     app_command = "cd #{np_service.path} && lrun bin/start_web_server.sh"
#   else
#     throw "Could not detect whether '#{convox_app}' is a ruby or node app."
#   end
# end


end