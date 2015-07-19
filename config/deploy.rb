# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'froshmate-landing-page'
set :repo_url, 'https://github.com/friendlymustache/landing-page.git'
set :deploy_to, "/home/ubuntu/froshmate/landing-page"

set :scm, :git
set :branch, "master"
set :scm_passphrase, ENV['SCM_PASSPHRASE']

set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :ssh_options, { :forward_agent => true }

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true
server "52.24.159.62", roles: [:app, :web, :db], :primary => true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
# set :stages, ["staging", "production"]
set :stages, ["production"]
set :default_stage, "production"



def thin_exec cmd
  run "cd #{current_path}; thin #{cmd.to_s} -C /etc/thin/#{application}.yml"
end
 
namespace :deploy do
  desc "Starts the thin application server"
  task :start do
    thin_exec :start
  end
  
  desc "Stops the thin application server"
  task :stop do
    thin_exec :stop
  end
  

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
        execute :rake, 'assets:precompile'
      end
    end
  end

  task :start do ; end
  task :stop do ; end

  # desc "Symlink shared config files"
  # task :symlink_config_files do
  #   run "#{ sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
  # end

  # NOTE: I don't use this anymore, but this is how I used to do it.
  desc "Precompile assets after deploy"
  task :precompile_assets do
    run <<-CMD
      cd #{ current_path } &&
      #{ sudo } bundle exec rake assets:precompile RAILS_ENV=#{ rails_env }
    CMD
  end

  desc "Restart application"
  task :restart do
      execute "service thin restart"  ## -> line you should add
  end  
  after :publishing, :restart

end
