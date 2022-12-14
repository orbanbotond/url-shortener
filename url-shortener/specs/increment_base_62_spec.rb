# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe UrlShortener::IncrementBase62 do
  describe '#increment' do
    subject(:increment) { described_class.new.increment(previous_counter) }

    let(:previous_counter) { '0' }

    it 'increases the letter 0 to 1' do
      expect(increment).to eq('1')
    end

    context 'when the previous url is "1"' do
      let(:previous_counter) { '1' }

      it 'increases the letter 1 to 2' do
        expect(increment).to eq('2')
      end
    end

    context 'when the numerical characters are out' do
      let(:previous_counter) { '9' }

      it 'shifts from 9 to a' do
        expect(increment).to eq('a')
      end

      context 'when there are 2 characters' do
        let(:previous_counter) { '19' }

        it 'shifts from 19 to 1a' do
          expect(increment).to eq('1a')
        end
      end
    end

    context 'when the lowercased numerical characters are out' do
      let(:previous_counter) { 'y' }

      it 'shifts from y to A' do
        expect(increment).to eq('A')
      end

      context 'when there are 2 characters' do
        let(:previous_counter) { '1y' }

        it 'shifts from 1y to 1A' do
          expect(increment).to eq('1A')
        end
      end
    end

    context 'when the last available character is reached' do
      let(:previous_counter) { 'Y' }

      it 'increases the number of characters' do
        expect(increment.length).to eq(2)
      end

      it 'change from Y to 10' do
        expect(increment).to eq('10')
      end

      context 'when there are 2 characters' do
        let(:previous_counter) { '1Y' }

        it 'shifts from 1Y to 20' do
          expect(increment).to eq('20')
        end

        context 'when all the characters are incremented' do
          let(:previous_counter) { 'YY' }

          it 'shifts from YY to 100' do
            expect(increment).to eq('100')
          end
        end
      end
    end

    context 'we increment 62^2 times' do
      it 'creates 3 digits' do
        base62_counter = described_class.new
        count = '0'

        (62**2).times do |_counter|
          count = base62_counter.increment(count)
        end

        expect(count.length).to eq(3)
        expect(count).to eq('100')

        count = '0'

        (62**3).times do |_counter|
          count = base62_counter.increment(count)
        end

        expect(count.length).to eq(4)
        expect(count).to eq('1000')
      end
    end
  end
end
