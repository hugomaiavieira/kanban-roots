require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'
  require 'valid_attribute'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  #Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec

    config.use_transactional_fixtures = true
  end

  def login(login, password)
    visit '/contributors/sign_in'
    fill_in('contributor_login', :with => login)
    fill_in('contributor_password', :with => password)
    click_button "Sign in"
  end
end

Spork.each_run do
end

