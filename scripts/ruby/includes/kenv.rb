# frozen_string_literal: false

require 'yaml'

class Kenv
  ENV_OVERRIDES = {
    # 'WB_LOCAL_STANDALONE' => 'true',
    # 'RAILS_ENV' => 'development'
    'TZ' => 'UTC' # all rails apps run in UTC time
  }.freeze

  def self.exec_with_env(cmd = nil, path: nil, env_path: nil, override_envs: {})
    env_args = []
    if env_path
      exit_with_error("env path '#{env_path}' not found") unless File.exist?(env_path)

      env_args.push "$(cat #{env_path} | xargs)"
      env_args.push ENV_OVERRIDES.merge(override_envs || {}).map { |k, v| "#{k}=#{v}" }.join(' ')
    end

    if cmd
      env_args.push "bash -ic '#{cmd}'"
    else
      env_args.push 'bash -i'
    end

    env_opts = []
    env_opts.push("--chdir='#{path}'") if path
    cmd = "env #{env_opts.join(' ')} #{env_args.join(' ')}"

    exec(cmd)
  end

  def self.exit_with_error(msg)
    puts "Error: #{msg}".red
    exit(1)
  end
end
