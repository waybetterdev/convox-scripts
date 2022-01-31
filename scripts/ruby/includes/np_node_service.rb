# frozen_string_literal: false

require_relative 'np_service.rb'

class NpNodeService < NpService
  def initialize(**args)
    super(**args)
  end

  def prepare_service
    return unless on_local_kraken?

    super
    prepare_local_service
  end

  def override_envs(environment)
    environment.eql?('development') ? { 'RAILS_ENV' => 'development' } : {}
  end

  def prepare_local_service; end

  def start_command
    "npsrun -a #{name} -e development -c \"nvm use && nvm ls && npm start\""
  end

  def run_command(cmd, environment: 'development')
    Kenv.exec_with_env(cmd, path: path, env_path: env_dst_path, override_envs: override_envs(environment))
  end

  def run_connect_command(environment: 'development')
    Kenv.exec_with_env(nil, path: path, env_path: env_dst_path, override_envs: override_envs(environment))
  end
end
