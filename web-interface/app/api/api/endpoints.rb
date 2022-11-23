# frozen_string_literal: true

module Api
  class Endpoints < Grape::API
    mount ShortUrl
  end
end
