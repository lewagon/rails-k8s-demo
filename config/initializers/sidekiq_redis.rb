$redis = Redis.new(url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0"), password: ENV["REDIS_PASSWORD"])

Sidekiq.configure_server do |config|
  config.redis = {url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0"), password: ENV["REDIS_PASSWORD"]}
end

Sidekiq.configure_client do |config|
  config.redis = {url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0"), password: ENV["REDIS_PASSWORD"]}
end
