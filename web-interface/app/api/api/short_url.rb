module Api
  class ShortUrl < Grape::API
    helpers Api::Helpers

    format :json

    params do
      requires :url, type: String, desc: 'The url to be encoded'
    end
    post :encode do
      shortened_url = shortener.encode params[:url]
      present ({url: shortened_url}), with: ::Entities::EncodedUrl
    end

    params do
      requires :url, type: String, desc: 'The url to be decoded'
    end
    post :decode do
      original_url = shortener.decode params[:url]
      present ({url: original_url }), with: ::Entities::DecodedUrl
    end
  end
end
