require 'resque'
Resque.redis = 'localhost:6379'
Resque.redis.namespace = "resque:whoswhoplus:#{Rails.env}"