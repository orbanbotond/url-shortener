# frozen_string_literal: true

$url_shortener_environment ||= :test

require_relative '../lib/url_shortener'
require 'database_cleaner-sequel'
require 'pry-nav'

DatabaseCleaner[:sequel].db = Sequel.connect(UrlShortener::DataMapper::DatabaseConnection.connection_uri(UrlShortener::DataMapper::DatabaseConnection.connection_options))

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner[:sequel].strategy = :truncation
  end
  config.before(:each) do
    DatabaseCleaner[:sequel].start
  end
  config.after(:each) do
    DatabaseCleaner[:sequel].clean
  end
end
