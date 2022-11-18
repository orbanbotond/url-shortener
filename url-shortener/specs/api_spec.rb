require_relative 'spec_helper'

RSpec.describe UrlShortener::Api do
  describe '#encode' do
    subject(:encoder) { described_class.new(base_url).encode(url) }
    let(:url) { "http://whatever.com" }
    let(:base_url) { "http://tny.com" }

    it 'return a new tiny url' do
      expect(encoder).to be_a(String)
    end

    it 'contains the base_url' do
      expect(encoder).to include(base_url)
    end

    it 'creates a DB record + genesis record' do
      repo = UrlShortener::DataMapper::DatabaseConnection.new(UrlShortener::DataMapper::DatabaseConnection.connection_options).shortened_url_repo

      expect { encoder }.to change { repo.count }.from(0).to(2)
    end

    context 'when we encode the same url we encoded previously' do
      it 'does not create a new DB record' do
        repo = UrlShortener::DataMapper::DatabaseConnection.new(UrlShortener::DataMapper::DatabaseConnection.connection_options).shortened_url_repo
        described_class.new(base_url).encode(url)

        expect { encoder }.to_not change { repo.count }
      end
    end

    context 'we encode consequtively' do
      it 'does creates multiple DB records' do
        repo = UrlShortener::DataMapper::DatabaseConnection.new(UrlShortener::DataMapper::DatabaseConnection.connection_options).shortened_url_repo

        expect do
          api = described_class.new(base_url)
          api.encode("http://google.com")
          api.encode("http://facebook.com")
        end.to change { repo.count }.from(0).to(3)
      end
    end

    context 'concurrency'
  end

  describe '#decode' do
    subject(:decode) { described_class.new(base_url).decode(shortened_url) }
    let(:url) { "http://whatever.com" }
    let(:base_url) { "http://tny.com" }
    let(:shortened_url) { described_class.new(base_url).encode(url) }

    it 'returns the original url' do
      expect(decode).to eq(url)
    end
  end
end
