# Set path to application
root_dir = File.expand_path('../../..', __FILE__)
shared_dir = "#{root_dir}/shared"
working_directory "#{root_dir}/current"

# Set unicorn options
worker_processes ENV['WEB_CONCURRENCY'] || 1
preload_app true
timeout 30

# Set up socket location
listen "#{shared_dir}/sockets/unicorn.sock", backlog: 64

# Logging
stderr_path "#{shared_dir}/log/unicorn.stderr.log"
stdout_path "#{shared_dir}/log/unicorn.stdout.log"

# Set master PID location
pid "#{shared_dir}/pids/unicorn.pid"
