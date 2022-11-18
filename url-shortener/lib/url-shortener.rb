require_relative 'url_shortener/increment_base_62.rb'
require_relative 'url_shortener/data_mapper/database_connection.rb'
require_relative 'url_shortener/api'

$url_shortener_environment ||= ENV['ENVIRONMENT'] || :development
