require 'resque'
require 'resque/scheduler'

Resque.redis = Redis.new(url: ENV['REDIS_URL'] || 'redis://localhost:6379')
Resque.schedule = YAML.load_file(Rails.root.join('config', 'resque_schedule.yml'))