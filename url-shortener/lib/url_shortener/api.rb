module UrlShortener
  class Api
    def initialize(base_url)
      @base_url = base_url

      create_genesis_record unless repo.last
    end

    def encode(url)
      record = repo.by_url url
      return record.shortened_url if record

      new_short_number = IncrementBase62.new.increment(previous_short_url)
      repo.create url: url, shortened_url: new_short_number, created_at: DateTime.now
      add_to_base_url(new_short_number)
    end

    def decode(short_url)
      short_number = trim_base_url(short_url)

      record = repo.by_shortened_url short_number
      record.url
    end

    private

    def base_url
      @base_url + "/"
    end

    def repo
      UrlShortener::DataMapper::DatabaseConnection.new(UrlShortener::DataMapper::DatabaseConnection.connection_options).shortened_url_repo
    end

    def previous_short_url
      repo.last.shortened_url
    end

    def create_genesis_record
      repo.create url: base_url, shortened_url: "0", created_at: DateTime.now
    end

    def add_to_base_url(new_short_url)
      base_url + new_short_url
    end

    def trim_base_url(short_url)
      short_url.sub base_url, ""
    end
  end
end