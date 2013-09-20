# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Blog::Application.load_tasks

begin
  require 'vlad'
  Vlad.load :app => :passenger, :scm => :git
rescue LoadError
  puts 'Could not load Vlad'
end

namespace :vlad do
 
  desc 'Restart Passenger'
  remote_task :restart_app, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
  
  desc 'Restarts the nginx server'
  remote_task :restart_web, :roles => :app do
    run "sudo service nginx restart"
  end

  desc 'Symlink paperclip storage directory'
  remote_task :symlink_config, :roles => :web do
    run "ln -s #{current_release}/public/system /home/josh/web_storage/blog/system"
  end

  desc "Full deployment cycle: Update, migrate, restart, cleanup"
  remote_task :deploy, :roles => :app do
    Rake::Task['vlad:update'].invoke
    Rake::Task['vlad:symlink_config'].invoke
    Rake::Task['vlad:migrate'].invoke
    Rake::Task['vlad:restart_app'].invoke
    Rake::Task['vlad:cleanup'].invoke
  end
end
