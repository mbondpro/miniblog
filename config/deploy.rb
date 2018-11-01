set :user, <user>
set :domain, <domain>
set :application, <app_name>

set :repository, "#{user}@#{domain}:git/#{application}.git"
set :deploy_to,  "/home/user/#{user}/#{application}/"

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

set :deploy_via, :remote_cache
set :scm, 'git'
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false

namespace :deploy do
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end

after "deploy:update_code", :bundle_install
desc "install the necessary prerequisites"
task :bundle_install, :roles => :app do
	run "cd #{release_path} && bundle install --deployment"
end
