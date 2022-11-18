require_relative 'spec_helper'

RSpec.describe UrlShortener::IncrementBase62 do
  describe '#increment' do
    subject(:increment) { described_class.new.increment(previous_url) }

    let(:previous_url) { '0' }

    it 'increases the letter 0 to 1' do
      expect(increment).to eq('1')
    end

    context 'when the previous url is "1"' do
      let(:previous_url) { '1' }

      it 'increases the letter 1 to 2' do
        expect(increment).to eq('2')
      end
    end

    context 'when the numerical characters are out' do
      let(:previous_url) { '9' }

      it 'shifts from 9 to a' do
        expect(increment).to eq('a')
      end

      context 'when there are 2 characters' do
        let(:previous_url) { '19' }

        it 'shifts from 19 to 1a' do
          expect(increment).to eq('1a')
        end
      end
    end

    context 'when the lowercased numerical characters are out' do
      let(:previous_url) { 'y' }

      it 'shifts from y to A' do
        expect(increment).to eq('A')
      end

      context 'when there are 2 characters' do
        let(:previous_url) { '1y' }

        it 'shifts from 1y to 1A' do
          expect(increment).to eq('1A')
        end
      end
    end

    context 'when the last available character is reached' do
      let(:previous_url) { 'Y' }

      it 'increases the number of characters' do
        expect(increment.length).to eq(2)
      end

      it 'change from Y to 00' do
        expect(increment).to eq("00")
      end

      context 'when there are 2 characters' do
        let(:previous_url) { '1Y' }

        it 'shifts from 1Y to 20' do
          expect(increment).to eq('20')
        end

        context 'when all the characters are incremented' do
          let(:previous_url) { 'YY' }

          it 'shifts from YY to 000' do
            expect(increment).to eq('000')
          end
        end
      end
    end
  end
end
