# frozen_string_literal: true

module UrlShortener
  class Api
    ShortUrlNotKnown = Class.new(StandardError)

    def initialize(base_url)
      @base_url = base_url

      create_genesis_record unless repo.last_record
    end

    def encode(url)
      record = repo.by_url url
      return add_to_base_url(record.shortened_url) if record

      new_short_number = nil

      # previous_locked do |_previous|
        new_short_number = IncrementBase62.new.increment(repo.last_record.shortened_url)
        repo.create url:, shortened_url: new_short_number, created_at: DateTime.now
      # end

      add_to_base_url(new_short_number)
    rescue
      retry
    end

    def decode(short_url)
      short_number = trim_base_url(short_url)

      record = repo.by_shortened_url short_number
      raise ShortUrlNotKnown unless record

      record.url
    end

    private

    def base_url
      "#{@base_url}/"
    end

    def repo
      @repo ||= UrlShortener::DataMapper::DatabaseConnection.shortened_url_repo
    end

    def previous_locked(&block)
      repo.locked_the_last(&block)
    end

    def create_genesis_record
      repo.create url: base_url, shortened_url: '0', created_at: DateTime.now
    end

    def add_to_base_url(new_short_url)
      base_url + new_short_url
    end

    def trim_base_url(short_url)
      short_url.sub base_url, ''
    end
  end
end
