# frozen_string_literal: false

require_relative 'np_service'

class NpDockerService < NpService
  def initialize(**args)
    super(**args)
  end

  def prepare_service
    return unless on_local_kraken?

    super
    prepare_local_service
  end

  def prepare_local_service
    'docker-compose build'
  end

  def start_command
    'docker-compose up'
  end
end
