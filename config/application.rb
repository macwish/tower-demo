require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TowerDemo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # app version
    VERSION = '1.0.0'

    # 
    config.time_zone = "Beijing"

    # sidekiq
    config.active_job.queue_adapter = :sidekiq

    # redis
    config.redis_config = YAML.load_file(Rails.root.join('config/redis.yml'))[Rails.env]
    raise RuntimeError.new('nil config.redis_config') if config.redis_config.blank?

  end
end
