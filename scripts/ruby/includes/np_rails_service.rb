# frozen_string_literal: true

require File.expand_path(__dir__) + '/np_service.rb'
require File.expand_path(__dir__) + '/kenv.rb'

class NpRailsService < NpService
  def initialize(**args)
    super(**args)
  end

  def prepare_service
    return unless on_local_kraken?
    
    super
    prepare_local_service
  end

  def prepare_local_service; end

  def start_command
    "np-service-run -a #{name} -e bin/start_web_server.sh"
  end

  def run_connect_command(override_envs: {})
    Kenv.exec_with_env(nil, path: path, env_path: env_dst_path, override_envs: override_envs)
  end

  def run_command(cmd, override_envs: {})
    Kenv.exec_with_env(cmd, path: path, env_path: env_dst_path, override_envs: override_envs)
  end
end
