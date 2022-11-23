# frozen_string_literal: true

require 'rom-sql'
require 'yaml'
require 'erb'
require_relative 'relations/shortened_urls'
require_relative 'repositories/shortened_url_repository'

module UrlShortener
  module DataMapper
    class DatabaseConnection
      class << self
        def connection_options
          db_config_file_location = File.join __dir__, '..', '..', '..', 'config', 'database.yml'
          erb = ERB.new(File.read(db_config_file_location))
          db_config = YAML.safe_load(erb.result, aliases: true)
          db_config[$url_shortener_environment.to_s]
        end

        def connection_uri(options)
          "postgres://#{options['username']}:#{options['password']}@#{options['host']}:#{options['port']}/#{options['database']}"
        end

        def init(db_config = {})
          config = ROM::Configuration.new(:sql, self.connection_uri(self.connection_options), db_config)
          config.register_relation(DataMapper::Relations::ShortenedUrls)

          @rom_container = ROM.container(config)
        end

        def shortened_url_repo
          init(UrlShortener::DataMapper::DatabaseConnection.connection_options)
          @shortened_url_repo ||= UrlShortener::DataMapper::Repositories::ShortenedUrlRepository.new(container: @rom_container)
        end
      end
    end
  end
end
