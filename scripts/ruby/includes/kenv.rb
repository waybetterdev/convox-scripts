# frozen_string_literal: true

class Kenv
  ENV_OVERRIDES = {
    'WB_LOCAL_STANDALONE' => 'true',
    'RAILS_ENV' => 'development'
  }.freeze

  def self.exec_with_env(cmd = nil, path: nil, env_path: nil)
    env_args = []
    if env_path
      env_args.push "$(cat #{env_path} | xargs)"
      env_args.push ENV_OVERRIDES.map { |k, v| "#{k}=#{v}" }.join(' ')
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
end
