# frozen_string_literal: true

require 'rom-repository'

module UrlShortener
  module DataMapper
    module Repositories
      class ShortenedUrlRepository < ROM::Repository[:shortened_urls]
        commands :create

        def count
          shortened_urls.count
        end

        def last
          shortened_urls.order { created_at.desc }.first
        end

        def by_url(url)
          shortened_urls.where(url: url).to_a.first
        end

        def by_shortened_url(shortened_url)
          shortened_urls.where(shortened_url: shortened_url).to_a.first
        end
      end
    end
  end
end
