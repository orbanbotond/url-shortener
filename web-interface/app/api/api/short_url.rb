# frozen_string_literal: true

module Api
  class ShortUrl < Grape::API
    helpers Api::Helpers

    rescue_from ::UrlShortener::Api::ShortUrlNotKnown do |_e|
      http_return_code = 404

      rack_response({ error: 'url not known' }.to_json, http_return_code)
    end

    format :json

    params do
      requires :url, type: String, desc: 'The url to be encoded'
    end
    post :encode do
      shortened_url = shortener.encode params[:url]
      present ({ url: shortened_url }), with: ::Entities::EncodedUrl
    end

    params do
      requires :url, type: String, desc: 'The url to be decoded'
    end
    post :decode do
      original_url = shortener.decode params[:url]
      present ({ url: original_url }), with: ::Entities::DecodedUrl
    end
  end
end
