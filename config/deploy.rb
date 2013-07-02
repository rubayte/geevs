##set :application, "geevs"
set :repository,  "https://github.com/rubayte/geevs.git"
set :user, "rrahman"
set :use_sudo, false
set :scm, :git
#set :deploy_via, :remote_cache

#set :scm, 'none' # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "www.ediva.crg.eu"                          # Your HTTP server, Apache/etc
role :app, "www.ediva.crg.eu"                          # This may be the same as your `Web` server
role :db,  "www.ediva.crg.eu", :primary => true        # This is where Rails migrations will run
#role :db,  "your slave db-server here"


set :deploy_to, "/var/www/html/geevs/" 

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

after "deploy", "deploy:bundle_gems"
after "deploy:bundle_gems", "deploy:restart"


# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :bundle_gems do
     run "cd #{deploy_to}/current && bundle install vendor/gems"
   end
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end