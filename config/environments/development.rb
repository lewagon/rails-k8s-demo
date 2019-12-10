Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Docker will expose port on one of those subnets, so we permit them
  config.web_console.permissions = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]

  # Sadly, not documented anywhere, but required since Rails 6
  config.hosts << ".ngrok.io"

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp", "caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}",
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.active_job.queue_adapter = :sidekiq

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end

HttpLog.configure do |config|
  # Enable or disable all logging
  config.enabled = true

  # You can assign a different logger or method to call on that logger
  config.logger = Logger.new($stdout)
  config.logger_method = :log

  # I really wouldn't change this...
  config.severity = Logger::Severity::DEBUG

  # Tweak which parts of the HTTP cycle to log...
  config.log_connect = true
  config.log_request = true
  config.log_headers = true
  config.log_data = true
  config.log_status = true
  config.log_response = false
  config.log_benchmark = true

  # ...or log all request as a single line by setting this to `true`
  config.compact_log = true

  # You can also log in JSON format
  config.json_log = false

  # Prettify the output - see below
  config.color = false

  # Limit logging based on URL patterns
  config.url_whitelist_pattern = nil
  config.url_blacklist_pattern = nil
end
