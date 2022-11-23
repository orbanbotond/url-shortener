# frozen_string_literal: true

module Api
  module Helpers
    def shortener
      UrlShortener::Api.new('http://tny.cm')
    end
  end
end
