REDIS_CLIENT = Redis.new(Rails.application.config_for(:redis))

# Clear db when in test or development mode
REDIS_CLIENT.flushdb if Rails.env.test?
