class ConvoxUtil

  def self.convox_app_exists?(convox_app, use_cache: false)
    return false if convox_app.nil?

    list_convox_apps(use_cache: use_cache).include?(convox_app)
  end

  def self.list_convox_apps(use_cache: false)
    @_convox_apps = nil unless use_cache
    @_convox_apps ||= begin
      exec_command('convox apps')
    end

    return [] unless @_convox_apps

    @_convox_apps.scan(/\n([\w-]+)/).flatten
  end

  def self.exec_command(cmd, message: nil)
    puts message  if message

    cmd.gsub("'", "\\\\'")
    `#{cmd}`
  end

end