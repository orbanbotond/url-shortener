# frozen_string_literal: true

module UrlShortener
  module DataMapper
    module Relations
      class ShortenedUrls < ROM::Relation[:sql]
        schema(:shortened_urls, infer: true) do
        end
      end
    end
  end
end
