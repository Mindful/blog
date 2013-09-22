set :application, "blog"
set :domain, "jserv.webhop.net"
set :deploy_to, "/home/josh/blog"
set :repository, "git@github.com:Mindful/blog.git"
set :revision, "origin/master"
set :web, "nginx"
set :user, "josh"

namespace :vlad do
  desc "Symlinks the configuration files"
  remote_task :symlink_config, :roles => :web do
      run "ln -sfn #{shared_path}/system #{current_path}/public/system"
  end

end
set :deploy_tasks, %w(
  vlad:update
  vlad:bundle:install
  vlad:symlink_config
  vlad:assets:precompile
  vlad:migrate
  vlad:start_app
  vlad:cleanup)


require 'bundler/vlad'