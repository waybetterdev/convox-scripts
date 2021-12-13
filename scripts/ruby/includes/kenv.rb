# frozen_string_literal: true

require 'yaml'

class Kenv
  ENV_OVERRIDES = {
    'WB_LOCAL_STANDALONE' => 'true',
    'RAILS_ENV' => 'development'
  }.freeze


  def self.read_env_from_file(file)
    yml = load_convox_yml(file)
    parse_environment_section(yml["environment"])
  end

  def self.load_convox_yml(file)
    YAML.load(File.read(file))
  end

  def self.parse_environment_section(environment = [])
    pairs = (environment || []).map do |entry|
      pair = entry.split("=", 2)
      pair[1] = pair[1].nil? || pair[1].empty? ? nil : pair[1]
      pair
    end
    Hash[pairs]
  end


  def self.exec_with_env(cmd = nil, path: nil, env_path: nil, override_envs: {})
    env_args = []
    if env_path
      env_args.push "$(cat #{env_path} | xargs)"
      env_args.push ENV_OVERRIDES.merge(override_envs).map { |k, v| "#{k}=#{v}" }.join(' ')
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
