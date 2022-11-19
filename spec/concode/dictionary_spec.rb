require 'spec_helper'

describe Dictionary do
  subject { described_class }

  describe '::adjectives' do
    it 'returns an array' do
      expect(subject.adjectives).to be_an Array
      expect(subject.adjectives.count).to eq 1116
    end

    it 'is sorted by string size' do
      expect(subject.adjectives.first.size).to eq 3
      expect(subject.adjectives.last.size).to eq 13
    end
  end

  describe '::nouns' do
    it 'returns an array' do
      expect(subject.nouns).to be_an Array
      expect(subject.nouns.count).to eq 1525
    end

    it 'is sorted by string size' do
      expect(subject.nouns.first.size).to eq 1
      expect(subject.nouns.last.size).to eq 14
    end
  end

  describe '::adjective_lengths' do
    it 'returns a hash of lengths' do
      expected = { 3 => 24, 4 => 130, 5 => 325, 6 => 499, 7 => 671, 8 => 847, 9 => 973 }
      expect(subject.adjective_lengths).to eq expected
    end
  end

  describe '::noun_lengths' do
    it 'returns a hash of lengths' do
      expected = { 3 => 115, 4 => 438, 5 => 742, 6 => 987, 7 => 1176, 8 => 1311, 9 => 1393 }
      expect(subject.noun_lengths).to eq expected
    end
  end
end
