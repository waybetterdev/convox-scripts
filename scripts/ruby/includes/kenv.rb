# frozen_string_literal: false

require 'fileutils'

class Kenv
  ENV_OVERRIDES = {
    # 'WB_LOCAL_STANDALONE' => 'true',
    # 'RAILS_ENV' => 'development'
    'TZ' => 'UTC' # all rails apps run in UTC time
  }.freeze

  attr_accessor :app_name, :env_path, :override_envs, :env_vars, :home_path

  def initialize(env_path: nil, override_envs: {}, app_name: nil)
    @env_path = env_path
    @override_envs = override_envs
    @app_name = app_name
    @home_path = File.expand_path('~')

    build_env_vars
  end

  def self.exec_with_env(cmd = nil, path:, env_path:, override_envs: {}, app_name: 'temp')
    kenv = new(env_path: env_path, override_envs: override_envs, app_name: app_name)

    kenv.exec_with_env(cmd, path)
  end

  def exec_with_env(cmd, path = nil)
    args = []
    prepare_rcfile(path)
    args.push("--rcfile '#{rcfile_path}'")

    if cmd
      args.push "-ic '#{cmd}'"
    else
      args.push '-i'
    end

    bash_cmd = "bash #{args.join(' ')}"
    exec(bash_cmd)
  end

  private

  def build_env_vars
    @env_vars = []
    if env_path
      exit_with_error("env path '#{env_path}' not found") unless File.exist?(env_path)

      @env_vars += File.read(env_path).split("\n").map do |line|
        k, v = line.gsub(/\n|\r/, '').split('=', 2)
        "#{k}='#{v}'"
      end
    end
    @env_vars += ENV_OVERRIDES.merge(override_envs || {}).map { |k, v| "#{k}='#{v}'" }
  end

  def exit_with_error(msg)
    puts "Error: #{msg}".red
    exit(1)
  end

  def prepare_rcfile(cwd_path = nil)
    lines = bashrc_envs + env_vars.map { |v| v.empty? ? '' : "declare -x #{v}" } + [cmd_change_color]

    lines << cmd_change_path(cwd_path) if cwd_path
    
    dirname = File.dirname(rcfile_path)
    FileUtils.mkdir_p(dirname) unless File.directory?(dirname)

    File.write(rcfile_path, lines.join("\n"), mode: "w")
  end

  def rcfile_path
    "#{home_path}/Work/docs/local-settings/bashrc/#{app_name}.bashrc"
  end

  def bashrc_envs
    File.read("#{home_path}/.bashrc").split("\n")
  end

  def cmd_change_color
    red = '\[\033[01;31m\]'
    white = '\[\033[00m\]'
    blue = '\[\033[01;34m\]'

    'PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}' + red + app_name.upcase + white + ':' + blue + '\w' + white + '\$ "'
  end

  def cmd_change_path(cwd_path)
    "cd #{cwd_path}"
  end
end
