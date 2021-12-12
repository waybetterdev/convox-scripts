require_relative 'np_service.rb'

class NpDockerService < NpService

  def initialize(**args)
    super(**args)
  end

  def prepare_service
    prepare_local_service if on_local_kraken?
  end

  def prepare_local_service
    'docker-compose build'
  end

  def start_command
    'docker-compose up'
  end
end