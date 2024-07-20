# frozen_string_literal: true

require 'simplecov'
SimpleCov.start 'rails'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner[:active_record].strategy = :transaction
    DatabaseCleaner[:mongoid].strategy = :deletion

    DatabaseCleaner[:active_record].clean_with(:truncation)
    DatabaseCleaner[:mongoid].clean_with(:deletion)
  end

  config.before(:each) do |example|
    if example.metadata[:type] == :model
      DatabaseCleaner[:active_record].start
      DatabaseCleaner[:mongoid].start
    end
  end

  config.after(:each) do |example|
    if example.metadata[:type] == :model
      DatabaseCleaner[:active_record].clean
      DatabaseCleaner[:mongoid].clean
    end
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.before(:suite) do
    Resque.inline = true
  end

  config.after(:suite) do
    Resque.inline = false
  end
end
