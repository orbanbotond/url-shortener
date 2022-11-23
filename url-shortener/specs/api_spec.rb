# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe UrlShortener::Api do
  describe '#encode' do
    subject(:encoder) { described_class.new(base_url).encode(url) }
    let(:url) { 'http://whatever.com' }
    let(:base_url) { 'http://tny.com' }
    let(:repo) { UrlShortener::DataMapper::DatabaseConnection.shortened_url_repo }

    it 'return a new tiny url' do
      expect(encoder).to be_a(String)
    end

    it 'contains the base_url' do
      expect(encoder).to include(base_url)
    end

    it 'creates a DB record + genesis record' do
      expect { encoder }.to change { repo.count }.from(0).to(2)
    end

    context 'when we encode the same url we encoded previously' do
      it 'does not create a new DB record' do
        described_class.new(base_url).encode(url)

        expect { encoder }.to_not change { repo.count }
      end
    end

    context 'we encode consequtively' do
      it 'does creates multiple DB records' do
        expect do
          api = described_class.new(base_url)
          api.encode('http://google.com')
          api.encode('http://facebook.com')
        end.to change { repo.count }.from(0).to(3)
      end
    end
  end

  describe '#decode' do
    subject(:decode) { described_class.new(base_url).decode(shortened_url) }
    let(:url) { 'http://whatever.com' }
    let(:base_url) { 'http://tny.com' }
    let(:shortened_url) { described_class.new(base_url).encode(url) }

    it 'returns the original url' do
      expect(decode).to eq(url)
    end

    context 'when trying to decode a nonexistent url' do
      let(:shortened_url) { 'http://nonexistent.url' }

      it 'raises a ShortUrlNotKnown exception' do
        expect { decode }.to raise_error(UrlShortener::Api::ShortUrlNotKnown)
      end
    end
  end
end
