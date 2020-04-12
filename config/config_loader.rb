require 'yaml'
require 'ostruct'

module ConfigLoader
  USER_CONFIGS = "config/config.yml"

  module_function

  # Load configurations in order:
  # - user
  # - env
  #
  # Env configs override user configs
  def load_app_config
    user_configs = read_yaml_file(USER_CONFIGS)
    environment_configs = Maybe(ENV).or_else({})

    # Order: user, env
    config_order = [user_configs, environment_configs]

    configs = config_order.inject { |a, b| a.merge(b) }
    OpenStruct.new(configs.symbolize_keys)
  end

  def read_yaml_file(file)
    abs_path = "#{Rails.root}/#{file}"
    file_content = if File.exists?(abs_path)
      YAML.load(ERB.new(File.read(abs_path)).result)[Rails.env]
    end

    Maybe(file_content).or_else({})
  end
end
