
class OpBase

  def load_settings
    if File.exists?("#{path_local_settings}/op-servers-config.rb")
      require "#{path_local_settings}/op-servers-config.rb" 
    elsif File.exists?("#{path_templates}/op-servers-config.rb")
      require "#{path_templates}/op-servers-config.rb"
    else
      exit_with_error("Could not find 'op-servers-config.rb' either in local-settings or templates")
    end
  end

  def servers
    OpServers::SERVERS
  end

  def hostnames
    OpServers::HOSTNAMES
  end

  protected
  def base_path
    @base_path ||= File.expand_path('../../../../', __FILE__)
  end

  def path_templates
    "#{base_path}/configs/templates"
  end

  def path_local_settings
    "#{base_path}/local-settings"
  end

  def deploy_config(name)
    name = name.to_s.gsub(/[ -]+/, "_").downcase.to_sym
    @__deploy_config ||= {}
    @__deploy_config[name] ||= begin
      res = servers[name].clone
      res[:hostnames].map!{ |h| hostnames[h] }
      res
    end
    @__deploy_config[name]
  end

  def ssh_config(name)
    name = name.to_s.gsub(/[ -]+/, "_").downcase.to_sym
    @__ssh_config ||= {}
    @__ssh_config[name] ||= begin
      conf = servers.map{ |k, v| v[:hostnames].include?(name) ? v : nil }.compact.first

      throw "Config for #{name} not found" if conf.nil?
      conf.merge({hostname: hostnames[name]})
          .slice(:user, :key, :hostname, :dst, :port, :deploy_path, :zip_name)
    end
    @__ssh_config[name]
  end

  def server_names
    hostnames.keys
  end

  def add_debug_option(opts)
    opts.on("-z", "--debug", "Optional: load pry") do |x|
      puts "Loaded pry in debug mode".red
      require 'pry'
      self.debug = true
    end
  end

  def add_help_option(opts)
    opts.on("-h", "--help", "Prints this help") do
      puts opts
      exit
    end
  end

  def add_op_app_option(opts)
    opts.on("-a", "--app=A", "Required, application (website name)") do |x|
      self.app = x
    end
  end

  def exec_command(cmd)
    puts "Running command: '#{cmd}'"  if self.debug 
    cmd.gsub("'", "\\\\'")
    %x[ #{cmd} ]
  end

  def exit_with_error(msg)
    puts "Error: #{msg}".red
    show_help
    exit(1)
  end

  def show_help
    puts self.option_parser.nil? ? HELP : self.option_parser
  end
end