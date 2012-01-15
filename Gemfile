source 'http://rubygems.org'

gem 'rails', '3.1.3'
gem 'mysql2', '~>0.3'

gem 'slim', '~>1.0'
gem 'simple_form',  '~>1.5'
gem 'inherited_resources', '~>1.2'
gem 'escape_utils', '~>0.2'
gem 'devise', '~>1.4'
gem 'redcarpet', '~>1.17' # Markdown
gem 'albino', '~>1.3' # Markdown syntax highlighting
gem 'nokogiri', '~>1.5' # Parse the html for markdown syntax highlighting
gem 'jquery-rails', '~>1.0'
gem 'ruby-json', '~>1.1'

group :assets do
  gem 'therubyracer' # JavaScript runtime. uglifier dependence
  gem 'uglifier'
end

group :development, :test do
  gem 'sqlite3-ruby'
  gem 'factory_girl_rails', '~>1.1'
  gem 'rspec', '~>2.6'
  gem 'rspec-rails', '~>2.6'
  gem 'valid_attribute', '~>1.1'
  gem 'capybara', '~>1.0'
  gem 'launchy', '>=2.0' # save_and_open_page
  gem 'cucumber-rails', '~>1.0'
  gem 'database_cleaner', '~>0.6'

  # Speedy test iterations
  gem 'spork', '~> 0.9.0.rc' # See: http://www.rubyinside.com/how-to-rails-3-and-rspec-2-4336.html
end

group :development do
  gem 'rails3-generators'
  gem 'pry'
  gem 'pry-doc'
end