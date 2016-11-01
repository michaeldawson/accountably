# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/rbenv'
require 'capistrano/env'
require 'capistrano/deploy'
require 'capistrano/unicorn_nginx'
require 'capistrano/rails'

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
