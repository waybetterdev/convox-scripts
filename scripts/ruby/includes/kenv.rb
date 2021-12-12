# frozen_string_literal: true

require_relative '../../../../wb-services/kraken/lib/wb/kenv'

class Kenv < Wb::Kenv
  def self.convox_yml_file(app)
    "#{Dir.home}/Work/docs/local-settings/convox-yml/#{app}.convox.local.yml"
  end

  def self.exec_with_env(app:, service:, args: [], extra_env: {}, global_env_fn: nil)
    defaults = global_env(global_env_fn)
    # precedence:
    # - shell ENV
    # - extra_env, which overwrites:
    # - convox env for service, which overwrites:
    #
    #
    env = compile_local_env(
      app: app,
      service: service,
      defaults: defaults
    ).merge(extra_env).merge(ENV.to_h)
    if args.empty?
      env.keys.sort.each { |k| puts "#{k}=#{env[k]}" }
    elsif !system(env, *args)
      raise "Error running command: #{$CHILD_STATUS.inspect}"
    end
  end
end
