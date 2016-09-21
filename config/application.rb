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

module Accountable
  class Application < Rails::Application
    config.assets.paths << "#{Rails}/app/assets/fonts"

    config.generators do |g|
      g.view_specs false
      g.helper_specs false
    end
  end
end
