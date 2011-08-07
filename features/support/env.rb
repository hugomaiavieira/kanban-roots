require 'spork'

Spork.prefork do
  require 'cucumber/rails'

  Capybara.default_selector = :css

  ActionController::Base.allow_rescue = false

  Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
    DatabaseCleaner.strategy = :truncation, {:except => %w[widgets]}
  end

  Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
    DatabaseCleaner.strategy = :transaction
  end
end

Spork.each_run do
end

