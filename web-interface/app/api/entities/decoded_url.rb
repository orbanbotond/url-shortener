module Entities
  class DecodedUrl < Grape::Entity
    expose :url, as: :decoded_url
  end
end