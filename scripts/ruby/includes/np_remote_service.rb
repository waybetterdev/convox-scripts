# frozen_string_literal: false

require_relative 'np_service'

class NpRemoteService < NpService
  def run_command(*)
    exit_with_error "#{name} is running as remote service. Cannot run it locally."
  end

  def run_connect_command(*)
    exit_with_error "#{name} is running as remote service. Cannot run it locally."
  end
end
