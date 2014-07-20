require 'resque'
Resque.redis = 'localhost:6379'
Resque.redis.namespace = "resque:data_loader:#{Rails.env}"