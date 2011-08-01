# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
require 'rake/dsl_definition' # http://migre.me/5nonc

KanbanRoots::Application.load_tasks

desc 'run all specs in development mode'
task :dev => ['dev:rspec', 'dev:cucumber:all']

namespace :dev do

  desc 'reset the database'
  task :database => ['db:drop:all', 'db:create:all', 'db:migrate', 'db:test:clone']

  desc 'run rspec specs'
  task :rspec do
    sh 'rspec spec --format progress'
  end

  desc 'run cucumber specs'
  namespace :cucumber do

    desc 'without javascript'
    task :nojavascript do
      sh 'cucumber features --tag ~@javascript --format progress'
    end

    desc 'with javascript'
    task :javascript do
      sh 'cucumber features --tag @javascript --format progress'
    end

    desc 'run all specs, with and without javascript'
    task :all => ['nojavascript', 'javascript']

  end

end


desc 'run all specs in travis-ci mode'
task :travis => ['travis:database', 'travis:specs']

namespace :travis do

  desc 'run rspec and cucumber specs'
  task :specs => ['dev:rspec', 'dev:cucumber:nojavascript']

  desc 'reset the database'
  task :database => ['db:drop', 'db:create', 'db:migrate']

end

