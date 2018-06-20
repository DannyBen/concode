require 'spec_helper'

describe Generator do
  describe '#initialize' do
    it "sets default attributes" do
      expect(subject.words).to eq 2
      expect(subject.chars).to eq 0
      expect(subject.glue).to eq '-'
      expect(subject.capitalize).to be false
    end

    it "sets chars to 3 when chars is 1 or 2" do
      [1,2].each do |i|
        expect(described_class.new(chars: i).chars).to eq 3
      end
    end

    it "sets chars to 0 when chars is greater than 9" do
      expect(described_class.new(chars: 10).chars).to eq 0
    end
  end

  describe '#generate' do
    it "works" do
      expect(subject.generate 'asd').to eq 'delicious-lead'
    end

    context 'with words argument' do
      it "works" do
        actual = {}
        (1..9).each do |i|
          actual[i] = described_class.new(words: i).generate 'asd'
        end
        expect(actual.to_yaml).to match_fixture 'generator/words_argument'
      end
    end

    context 'with chars argument' do
      it "works" do
        actual = {}
        (3..9).each do |i|
          actual[i] = described_class.new(chars: i).generate 'asd'
        end
        expect(actual.to_yaml).to match_fixture 'generator/chars_argument'
      end
    end

    context 'with glue argument' do
      subject { described_class.new glue: ' ' }

      it "uses the glue to join the words" do
        expect(subject.generate 'asd').to eq 'delicious lead'
      end
    end

    context 'with capitalize' do
      subject { described_class.new words: 3, chars: 2, capitalize: true }
      
      it "capitalizes words" do
        expect(subject.generate 'asd').to eq 'Few-Far-Ask'
      end
    end
  end

  describe '#word_count' do
    it "returns the total number of words in the space" do
      actual = {}
      (1..3).each do |words|
        [3,4,5,6,7,8,9,0].each do |chars|
          actual["#{words} words, #{chars} chars"] = described_class.new(words: words, chars: chars).word_count
        end
      end
      expect(actual.to_yaml).to match_fixture('generator/word_count')
    end
  end
end
