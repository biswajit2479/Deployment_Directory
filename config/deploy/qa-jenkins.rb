set :stage, "qa-jenkins"
set :rails_env, "qa"

server "qa-jenkins-internal.jifflenow.com", roles: %w{app web db create_db}

set :ssh_options, {
  keys: %w(~/.ssh/digitalocean201811),
  user: "minions"
}

# Atlast load the Ngen_Env runner
load File.expand_path(File.join(File.dirname(__FILE__),'ngen_env.rb'))
