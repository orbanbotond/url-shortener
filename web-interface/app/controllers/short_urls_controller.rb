class ShortUrlsController < ApplicationController
	def index
	end

	def create
		@shortened_url = shortener.encode params[:url]
	end

	def decode
		@original_url = shortener.decode params[:shortened_url]
	end

	private

	def shortener
		UrlShortener::Api.new('http://tny.cm')
	end
end
