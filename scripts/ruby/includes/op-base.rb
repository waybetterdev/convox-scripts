
class OpBase

  attr_accessor :option_parser, :debug

  ################ OP SERVERS ###################
  def load_op_severs_config
    if File.exists?("#{path_local_settings}/op-servers-config.rb")
      require "#{path_local_settings}/op-servers-config.rb" 
    elsif File.exists?("#{path_templates}/op-servers-config.rb")
      require "#{path_templates}/op-servers-config.rb"
    else
      exit_with_error("Could not find 'op-servers-config.rb' either in local-settings or templates")
    end
  end

  def servers
    unless defined?(OpServers) == 'constant'
      load_op_severs_config
    end

    OpServers::SERVERS
  end

  def hostnames
    OpServers::HOSTNAMES
  end
  ################ OP SERVERS ###################

  ################ NP SERVICES ###################
  def load_np_services_config
    if File.exists?("#{path_local_settings}/np-services-config.rb")
      require "#{path_local_settings}/np-services-config.rb" 
    elsif File.exists?("#{path_templates}/np-services-config.rb")
      require "#{path_templates}/np-services-config.rb"
    else
      exit_with_error("Could not find 'np-services-config.rb' either in local-settings or templates")
    end
  end

  def np_services
    unless defined?(NpServices) == 'constant'
      load_np_services_config
    end
    @__np_services ||= begin
      [
        NpServices::NP_SERVICES[:local_kraken].map          { |s| s.merge(location: 'kraken') },
        NpServices::NP_SERVICES[:local_convox].map          { |s| s.merge(location: 'convox-local') },
        NpServices::NP_SERVICES[:remote_convox_office].map  { |s| s.merge(location: 'remote-convox-office') },
        NpServices::NP_SERVICES[:local_apache].map          { |s| s.merge(location: 'apache-local') },
      ]
      .flatten
      .each_with_object({}) do |service_data, hash|
        name = dashed_app_name(service_data[:name]).to_sym
        folder_name = service_data[:name]
        service_data[:path] ||= (service_data[:location] == 'kraken') ? "#{path_kraken}/#{folder_name}" : "#{path_wb_services}/#{folder_name}"
        hash[name] = service_data
      end
    end
    @__np_services
  end

  def is_convox_office_server
    @_res ||= NpServices::CONFING_TYPE == NpServices::CONFIG_TYPE_COVOX_OFFICE
  end
  ################ NP SERVICES ###################


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

  def path_secrets
    "#{base_path}/secrets"
  end

  def path_install_scripts
    "#{base_path}/scripts/installs"
  end

  def path_wb_services
    "#{Dir.home}/Work/wb-services"
  end

  def path_kraken
    "#{Dir.home}/Work/wb-services/kraken"
  end

  def hyphenated_app_name(name)
    name.to_s.gsub(/[ _]+/, "-").downcase
  end

  def dashed_app_name(name)
    name.to_s.gsub(/[ -]+/, "_").downcase
  end

  ################ OP SERVERS ###################
  def op_deploy_config(name)
    name = dashed_app_name(name).to_sym
    @__op_deploy_config ||= {}
    @__op_deploy_config[name] ||= begin
      res = servers[name].clone
      res[:hostnames].map!{ |h| hostnames[h] }
      res
    end
    @__op_deploy_config[name]
  end

  def ssh_config(name)
    name = dashed_app_name(name).to_sym
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
  ################ OP SERVERS ###################

  ################ NP SERVICES ###################
  def np_service_config(name, exit_on_fail = false)
    config = np_services[dashed_app_name(name).to_sym]
    exit_with_error "NP service config for #{name} not found" unless config

    config
  end

  def np_service_app_name(name)
    np_service_config(name)[:name]
  end

  def np_service_path(name)
    np_service_config(name)[:path]
  end

  def np_service_location(name)
    np_service_config(name)[:location]
  end

  def np_service_port(name)
    np_service_config(name)[:port]
  end

  def np_service_is_on_convox_office(name)
    np_service_location(name) == 'remote-convox-office'
  end

  def np_service_is_on_local_kraken(name)
    np_service_location(name) == 'kraken'
  end

  def np_service_is_on_local_convox(name)
    np_service_location(name) == 'convox-local'
  end

  def np_service_is_on_local_apache(name)
    np_service_location(name) == 'apache-local'
  end

  ################ NP SERVICES ###################

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
      self.opts_op_app = x
    end
  end

  def add_np_app_option(opts)
    opts.on("-a", "--app=A", "Required, NP application name") do |x|
      x  = 'wb-auth-service' if x == 'auth'
      pattern = Regexp.new(x)
      res = np_services.find { |k,v| pattern =~ v[:name] }
      exit_with_error "Did not find any NP services for pattern '*#{x}*'" unless res
      self.opts_np_app = res[1][:name]
    end
  end

  def exec_command(cmd, message: nil)
    puts "Running command: '#{cmd}'"  if self.debug 
    puts message  if message

    cmd.gsub("'", "\\\\'")
    %x[ #{cmd} ]
  end

  def exec_command_1(cmd, exit_on_fail: true, message: nil)
    puts message if message
    result = system cmd
    if result
      return result
    else
      warn "FAIL: '#{cmd}', exiting: #{exit_on_fail}"
      exit 1 if exit_on_fail
    end
  end

  def exec_bash_command(cmd, exit_on_fail: true, message: nil)
    cmd = "/bin/bash -ic '#{cmd}'"
    exec_command_1(cmd, exit_on_fail: exit_on_fail, message: message)
  end


  def exit_with_error(msg)
    puts "Error: #{msg}".red
    exit(1)
  end

  def show_help
    puts self.option_parser.nil? ? HELP : self.option_parser
  end

  def run_ssh_command(user, host, key, command, port = 22)
    puts "Connecting to #{user}@#{host}".green
    response = exec_command("ssh -i #{key} #{user}@#{host} -p #{port} -t '#{command}'")
    print response.green
  end

  def checkout_app(name:, path:)
    name = hyphenated_app_name(name)

    gitname = (name == 'kraken') ? 'kraken' : np_service_config(name)[:gitname]

    exec_command "cd #{path} && git clone git@github.com:wbetterdev/#{gitname}.git #{name}", 
      message: "Cloning #{name} from git"
  end

  def np_service_domain(name, location: nil)
    name = hyphenated_app_name(name)
    apply_location_to_np_service_domain("#{name}.convox.local", name, location)
  end

  def np_service_convox_domain(name)
    return "web.#{name}.dev.local" if np_service_is_on_local_convox(name)
  end

  def get_service_external_domain(name, variant: nil, location: nil)
    name = hyphenated_app_name(name)
    urls = {
      'wb-auth-service'       => { 'default' => 'accounts-local.waybetterdev.com' },
      'wb-graphql-service'    => { 'default' => 'graphql-local.waybetterdev.com', 'ninja' => 'graphql-local.waybetter.ninja'},
      'wb-hub'                => { 'default' => 'hub-local.waybetterdev.com' },
      'wb-admin-auth-service' => { 'default' => 'admin-auth-local.waybetter.ninja' },
      'wb-admin-web'          => { 'default' => 'www-local.waybetter.ninja' },
    }
    variant = 'default' unless variant
    url = urls[name][variant]
    return unless url

    apply_location_to_np_service_domain(url, name, location)
  end

  def apply_location_to_np_service_domain(domain, name, location = nil)
    if is_convox_office_server
      domain_part = 'office'
    else
      location ||= np_service_location(name)
      domain_part = (location == 'remote-convox-office') ? 'office' : 'local'
    end
    
    domain.gsub(/(local|office)/, domain_part)
  end

  def get_convox_service_domain(name)
    "web.#{name}.convox"
  end

  def get_local_ip
    @__get_local_ip ||= exec_command('hostname -I | egrep -oh 192.168.[0-9]+.[0-9]+').gsub("\n", "")
  end
end