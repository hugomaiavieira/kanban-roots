# Load the rails application
require File.expand_path('../application', __FILE__)

# XXX: Just to fix a bug introduced by RubyGems 1.5.0:
#   couldn't parse YAML at line 7 column 14 (Psych::SyntaxError)
# RubyGems 1.5.0 seems to force use of the psych yaml parser if you have it in
# your system. This make ruby use syck instead of psych to parse yaml.
require 'yaml'
YAML::ENGINE.yamler= 'syck'

# Initialize the rails application
KanbanRoots::Application.initialize!

