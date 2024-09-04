require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/1' }
  config.on(:startup) do
    Sidekiq::Scheduler.load_schedule!
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/1' }
end

