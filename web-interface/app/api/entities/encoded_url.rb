# frozen_string_literal: true

module Entities
  class EncodedUrl < Grape::Entity
    expose :url, as: :encoded_url
  end
end
