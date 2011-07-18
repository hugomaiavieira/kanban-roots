# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

KanbanRoots::Application.load_tasks

namespace :travis do

  desc 'reset the database'
  task :database => ['db:drop', 'db:create', 'db:migrate']

  desc 'run rspec specs'
  task :rspec do
    sh 'rspec spec'
  end

  desc 'run cucumber specs'
  task :cucumber do
    sh 'cucumber features'
  end

  desc 'run all tasks'
  task :all => ['database', 'rspec', 'cucumber']

end

