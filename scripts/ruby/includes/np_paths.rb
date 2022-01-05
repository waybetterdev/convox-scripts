# frozen_string_literal: false

class NpPaths
  def base_path
    @base_path ||= File.expand_path('../../..', __dir__)
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

  def path_ruby_bin
    "#{Dir.home}/Work/docs/scripts/ruby"
  end
end
