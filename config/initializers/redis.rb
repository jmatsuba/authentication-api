if Rails.env.production?
  REDIS_CLIENT = Redis.new(host: ENV['REDIS_URL'])
else
  REDIS_CLIENT = Redis.new(host: 'localhost')
end
