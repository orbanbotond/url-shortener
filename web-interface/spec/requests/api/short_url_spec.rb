# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api for short_url", type: :request do
  # TODO refactor this out to a helper
  def response_json
    @json ||= JSON.parse(response.body).with_indifferent_access
  end

  let(:url) { 'https://www.linkedin.com/in/orbanbotond/' }

  describe 'The encode endpoint' do
    subject(:call_request) do
      post "/encode", params: { url: url }
    end

    context 'when the url is present' do
      it "executes the query successfull" do
        call_request
        expect(response).to have_http_status(201)
        expect(response.content_type).to eq("application/json")
        expect { response_json }.to_not raise_error
        expect(response_json.keys).to include('encoded_url')
      end
    end

    context 'when the params are incomplete' do
      context 'when the url is empty' do
        subject(:call_request) do
          post "/encode", params: { url: '' }
        end

        it "executes the query successfull" do
          call_request
          expect(response).to have_http_status(201)
          expect(response.content_type).to eq("application/json")
          expect { response_json }.to_not raise_error
          expect(response_json.keys).to include('encoded_url')
        end
      end

      context 'when the url is missing' do
        subject(:call_request) do
          post "/encode", params: {}
        end

        it "executes the query successfull" do
          call_request
          expect(response).to have_http_status(400)
          expect(response.content_type).to eq("application/json")
          expect { response_json }.to_not raise_error
          expect(response_json.keys).to include('error')
          expect(response_json['error']).to include('url is missing')
        end
      end
    end
  end

  describe 'The decode endpoint' do
    subject(:call_request) do
      post "/decode", params: { url: shortened_url }
    end

    let(:shortened_url) do
      shortener = UrlShortener::Api.new('http://tny.cm')
      shortener.encode url
    end

    context 'when the url is present' do
      it "executes the query successfull" do
        call_request
        expect(response).to have_http_status(201)
        expect(response.content_type).to eq("application/json")
        expect { response_json }.to_not raise_error
        expect(response_json.keys).to include('decoded_url')
        expect(response_json['decoded_url']).to eq(url)
      end
    end

    context 'when the params are incomplete' do
      context 'when the url can not be found' do
        let(:shortened_url) { 'http://non-existing-url' }

        it "executes the query successfull" do
          call_request

          expect(response).to have_http_status(404)
          expect(response.content_type).to eq("application/json")
          expect { response_json }.to_not raise_error
          expect(response_json['error']).to include('url not known')
        end
      end

      context 'when the url is missing' do
        subject(:call_request) do
          post "/decode", params: {}
        end

        it "executes the query successfull" do
          call_request
          expect(response).to have_http_status(400)
          expect(response.content_type).to eq("application/json")
          expect { response_json }.to_not raise_error
          expect(response_json.keys).to include('error')
          expect(response_json['error']).to include('url is missing')
        end
      end
    end
  end
end
