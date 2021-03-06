# frozen_string_literal: true

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  is_cache_enabled = Rails.root.join("tmp/caching-dev.txt").exist?

  config.action_controller.perform_caching = is_cache_enabled

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = is_cache_enabled

  if is_cache_enabled
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: ENV.fetch("ANNICT_HOST") }
  config.action_mailer.delivery_method     = :letter_opener_web

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.after_initialize do
    Bullet.enable        = true
    Bullet.bullet_logger = true
    Bullet.console       = true
    Bullet.rails_logger  = true
  end

  # Vagrant環境でもBetter Errorsが使いたい
  # https://github.com/charliesome/better_errors#security
  # Wating to be fixed: https://github.com/charliesome/better_errors/issues/341
  # BetterErrors::Middleware.allow_ip! "192.168.33.1"

  # Inline Source Maps
  # https://github.com/sass/sassc-rails/tree/b76761dd7b3bda9df559cf35f332364878ec7ad8#inline-source-maps
  config.sass.inline_source_maps = true

  # https://github.com/ruckus/active-record-query-trace
  ActiveRecordQueryTrace.enabled = true
end
