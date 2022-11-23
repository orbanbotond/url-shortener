module Api
  class Endpoints < Grape::API
    mount ShortUrl
	end
end
