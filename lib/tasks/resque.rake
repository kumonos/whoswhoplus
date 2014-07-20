require 'resque/tasks'
require 'resque'
Resque.logger = Logger.new STDOUT
Resque.logger.level = Logger::INFO