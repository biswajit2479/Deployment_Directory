set :branch, ENV["CAP_TAG"] || "develop"
set :db_host, "localhost"
set :dbuser, "jiffledba"
set :dbpass, "Jiffle440"
set :environment_database, "#{fetch(:application)}_#{fetch(:rails_env)}"
set :bundle_env_variables, { path: "$PATH:/usr/pgsql-9.6/bin" }

namespace :deploy do
  desc "Configures the webserver and database"
  task :setup do
    invoke "postgresql:create_db"
    invoke "deploy:create_deploy_to_dir"
  end

  desc 'Runs rake db:seed'
  task :seed => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end

  desc "Creates the deploy-to directory."
  task :create_deploy_to_dir do
    on roles(:app) do
      execute "mkdir -p #{fetch(:deploy_to)}"
      execute "mkdir -p #{fetch(:deploy_to)}"
      execute "chown -R minions:minions #{fetch(:deploy_to)}"
      execute "chmod g+s #{fetch(:deploy_to)}"
      execute "mkdir -p #{fetch(:deploy_to)}/phusion"
      execute "rm -f #{fetch(:deploy_to)}/phusion/#{fetch(:application)}"
      execute "ln -s #{fetch(:deploy_to)}/current/public #{fetch(:deploy_to)}/phusion/#{fetch(:application)}"
    end
  end
  desc "Restart Application Server"
  task :restart do
    on roles(:app) do
      execute "sudo service nginx-passenger restart"
    end
  end
end




namespace :postgresql do
  desc "Create the database for this application"
  task :create_db do
    on roles(:db) do
      begin
        execute "PGPASSWORD=#{fetch(:dbpass)} /usr/pgsql-9.6/bin/psql -h #{fetch(:db_host)} -U #{fetch(:dbuser)} -d postgres -c \"CREATE DATABASE \\\"#{fetch(:environment_database)}\\\" WITH OWNER #{fetch(:dbuser)} ENCODING 'UTF8';\""
      rescue
        execute "echo 'PostgreSQL - db creation - some error occurred. continuing...'"
      end
    end
  end
end

namespace :setup do
  desc "Generate database.yml for this application"
  task :generate_dbyml do
    on roles(:app) do
      execute :mkdir, '-pv', shared_path.join('config')
      dbyml_path = "#{shared_path}/config/database.yml"
      base_db_yml = {
          "adapter" => "postgresql",
          "encoding" => "unicode",
          "database" => "#{fetch(:environment_database)}",
          "host" => "#{fetch(:db_host)}",
          "username" => "#{fetch(:dbuser)}",
          "password" => "#{fetch(:dbpass)}",
          "pool" => 5
        }
      final_database_yml = { "#{fetch(:rails_env)}" => base_db_yml }.to_yaml
      contents = StringIO.new(final_database_yml)
      upload! contents, dbyml_path
      set :linked_files, fetch(:linked_files, []).push('config/database.yml')
    end
  end
end

after 'deploy:started', "setup:generate_dbyml"
after 'deploy:publishing', "deploy:restart"
