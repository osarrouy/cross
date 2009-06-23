set :application, "cross"
set :repository, "git@github.com:osarrouy/cross.git"
set :scm, :git
set :runner, "rails"
set :user, "deploy"
set :branch, "master"
set :deploy_via, :remote_cache
set :keep_releases, 3 
set :box, "box"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

server "box", :app, :web, :db, :primary => true


set :deploy_to, "/home/rails/#{application}"

namespace :init do
  desc "Setting proper permissions for deploy user"
  task :set_permissions do
    sudo "chown -R #{user} #{deploy_to}"
  end
end

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "Such a #{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end

  desc "Invoke the db migration in production mode"
  task :migrate, :roles => :app do
    run "cd #{current_path} && rake db:migrate RAILS_ENV=production "   
  end

end