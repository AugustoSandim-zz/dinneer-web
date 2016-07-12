require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DinneerWeb
  class Application < Rails::Application

    config.time_zone = "Brasilia"
    config.i18n.available_locales = [:"pt-BR", :en]
    config.i18n.default_locale = :"pt-BR"

    config.autoload_paths += %W(#{config.root}/lib/api )
    config.autoload_paths += %W(#{config.root}/app)
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.active_record.raise_in_transactional_callbacks = true
  end
end
