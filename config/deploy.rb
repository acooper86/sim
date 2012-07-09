default_run_options[:pty] = true

set :application, "sim"
set :repository,  "git@github.com:acooper86/sim.git"

set :user, "adam"

set :scm, "git"
set :scm_passphrase, "textb00k"

set :branch, "master"

set :deploy_to, "/home/adam/public_html"
set :deploy_via, :remote_cache

role :web, "simplissage.com"                          # Your HTTP server, Apache/etc
role :app, "simplissage.com"                          # This may be the same as your `Web` server
role :db,  "simplissage.com", :primary => true        # This is where Rails migrations will run

set :port, 5555

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end