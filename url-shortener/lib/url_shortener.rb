# frozen_string_literal: true

require_relative 'url_shortener/increment_base_62'
require_relative 'url_shortener/data_mapper/database_connection'
require_relative 'url_shortener/api'

$url_shortener_environment ||= ENV['ENVIRONMENT'] || :development
