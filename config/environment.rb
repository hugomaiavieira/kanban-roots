# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.time_zone = 'UTC'

  config.gem 'haml'
  config.gem 'will_paginate'
  config.gem 'formtastic'
  config.gem 'inherited_resources', :version => '1.0.6'
  config.gem 'validation_reflection'
end

