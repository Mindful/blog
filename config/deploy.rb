set :application, "blog"
set :domain, "jserv.webhop.net"
set :deploy_to, "/home/josh/blog"
set :repository, "git@github.com:Mindful/blog.git"
set :revision, "origin/master"
set :web, "nginx"
set :user, "josh"

set :deploy_tasks, %w(
  vlad:update
  vlad:bundle:install
  vlad:assets:precompile
  vlad:migrate
  vlad:start_app
  vlad:cleanup)


require 'bundler/vlad'