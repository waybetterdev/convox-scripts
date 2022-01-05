# frozen_string_literal: false

require_relative 'np_service.rb'

class NpConvoxService < NpService
  def initialize(**args)
    super(**args)
  end

  def prepare_service
    return unless on_local_convox?

    super
    prepare_local_service
  end

  def prepare_local_service
    return if ConvoxUtil.convox_app_exists?(name, use_cache: true)

    create_convox_app
  end

  def create_convox_app
    exec_command([
      "cd #{path}",
      "convox apps create #{name}",
      "kmd-local refresh-env -- local #{name} no-confirm",
      "kmd-local refresh-yml -- local #{name} no-confirm"
    ].join(' && '))
  end

  def start_command
    "env-builder -w -a #{name} && kk refresh-yml -- local #{name} && kk refresh-env -- local #{name} no-confirm && startconvoxapp"
  end

  def run_connect_command
    exec_command("kk kon -- local #{name}")
  end
end
