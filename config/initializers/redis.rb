
redis_config = Rails.application.config.redis_config

if redis_config.present?
  $redis = Redis.new(redis_config)
end
