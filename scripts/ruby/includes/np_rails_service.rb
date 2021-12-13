# frozen_string_literal: true

require File.expand_path(__dir__) + '/np_service.rb'
require File.expand_path(__dir__) + '/kenv.rb'

class NpRailsService < NpService
  def initialize(**args)
    super(**args)
  end

  def prepare_service
    super
    prepare_local_service if on_local_kraken?
  end

  def prepare_local_service; end

  def start_command
    "np-service-run -a #{name} -e bin/start_web_server.sh"
  end

  def run_connect_command
    Kenv.exec_with_env(nil, path: path, env_path: env_dst_path)
  end

  def run_command(cmd)
    Kenv.exec_with_env(cmd, path: path, env_path: env_dst_path)
  end
end
