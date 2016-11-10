require File.expand_path('../boot', __FILE__)

require "rails"

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

require 'dotenv'
Dotenv::Railtie.load

module Accountable
  class Application < Rails::Application
    config.assets.paths << "#{Rails}/app/assets/fonts"
    config.autoload_paths += Dir["#{config.root}/lib/accountably/**/"]

    config.generators do |g|
      g.template_engine nil
      g.test_framework nil
      g.assets false
      g.helper false
      g.stylesheets false
    end
  end
end
