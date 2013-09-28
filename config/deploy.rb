set :application, "blog"
set :domain, "jserv.webhop.net"
set :deploy_to, "/home/josh/blog"
set :repository, "git@github.com:Mindful/blog.git"
set :revision, "origin/master"
set :web, "nginx"
set :user, "josh"


#The symlinking here may be redundant, but we need to delayed_job ourself because
#the directory has changed since vlad-extras was created (it's now in bin)
namespace :vlad do
  desc "Symlinks the configuration files"
  remote_task :symlink_config, :roles => :web do
      run "ln -sfn #{shared_path}/system #{current_path}/public/system"
      run "ln -sfn #{shared_path}/database.yml #{current_path}/config/database.yml"
      run "ln -sfn #{shared_path}/mandrill.yml #{current_path}/config/mandrill.yml"
  end

  desc "Restarts delayed_job"
  remote_task :restart_delayed_job, :roles => :app do
  	run "cd #{current_path} && RAILS_ENV=production bin/delayed_job restart"
  end

end
set :deploy_tasks, %w(
  vlad:update
  vlad:bundle:install
  vlad:symlink_config
  vlad:assets:precompile
  vlad:migrate
  vlad:restart_delayed_job
  vlad:start_app
  vlad:cleanup)


require 'bundler/vlad'