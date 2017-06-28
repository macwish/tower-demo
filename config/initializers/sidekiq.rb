
# redis config 

redis_config = Rails.application.config.redis_config

Sidekiq.configure_server do |config|
  config.redis = redis_config if redis_config.present?
end

Sidekiq.configure_client do |config|
  config.redis = redis_config if redis_config.present?
end

# 
# disable Sidekiq auto-retry
# 
Sidekiq.options[:max_retries] = 0
