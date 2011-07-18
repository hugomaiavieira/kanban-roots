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
    sh 'rspec spec --format progress'
  end

  desc 'run cucumber specs'
  namespace :cucumber do

    desc 'run cucumber specs without javascript'
    task :nojavascript
      sh 'cucumber features --tag ~@javascript --format progress'
    end

    desc 'run cucumber specs with javascript'
    task :javascript
      sh 'cucumber features --tag @javascript --format progress'
    end

    desc 'run all cucumber specs'
    tasks :all => ['nojavascript', 'javascript']

  end

  desc 'run all tasks'
  task :all => ['database', 'rspec', 'cucumber:nojavascript']

end

