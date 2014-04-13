env = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'staging'
listen "/apps/whoswhoplus/#{env}/tmp/sockets/#{env}.sock"
pid "/apps/whoswhoplus/#{env}/tmp/pids/#{env}.pid"
worker_processes 3
