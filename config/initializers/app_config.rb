# These needed to load the config.yml
require File.expand_path('../../config_loader', __FILE__)

# Read the config from the config.yml
APP_CONFIG = ConfigLoader.load_app_config
