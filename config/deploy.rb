set :application, 'deployment_directory'
set :repo_url, 'git@github.com:Jifflenow/deployment_directory.git'

set :deploy_to, "/home/minions/www/#{fetch(:application)}"

# set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :tmp_dir, "#{fetch(:deploy_to)}/tmp"
set :rvm_type, :user
set :rvm_ruby_version, '2.5.3'
set :bundle_binstubs, nil

SSHKit.config.command_map[:rake]  = "bundle exec rake"
SSHKit.config.command_map[:rails] = "bundle exec rails"
set :pty, true
