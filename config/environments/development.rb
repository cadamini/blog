Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # TODO: MOVE TO ENVIRONMENT
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: 'mail.gmx.de' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    user_name:      '',
    password:       '',
    domain:         '',
    address:       '',
    port:          '',
    authentication: :plain,
    enable_starttls_auto: true
  }
  
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  # Debug mode disables concatenation and preprocessing of assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # devise configuration
  # In production, :host should be set to the actual host of your application.
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
end
