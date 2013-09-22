# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

begin
  require 'vlad'
  require 'vlad-extras'
  Vlad.load(:web => :nginx, :app => :passenger, :scm => :git, :queue => :delayed_job)
rescue LoadError
  puts 'Could not load Vlad'
end

Blog::Application.load_tasks
