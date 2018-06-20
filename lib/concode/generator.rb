require 'digest'

module Concode
  class Generator
    attr_reader :words, :chars, :glue, :capitalize

    def initialize(words: 2, chars: 0, glue: '-', capitalize: false)
      @words = words
      @glue = glue
      @capitalize = capitalize
      @chars = chars

      @chars = 3 if @chars.between? 1, 3
      @chars = 0 if @chars > 9
    end

    def generate(text)
      result = generate_particles text
      result.map!(&:capitalize) if capitalize
      result.join glue
    end

    def word_count
      @word_count ||= particles.map(&:size).reduce(:*)
    end

    private

    def particles
      @particles ||= particles!
    end

    def particles!
      if chars == 0
        result = [ nouns ]
        adjective_count.times { result.push adjectives }
      else
        result = [ nouns[0...nouns_length] ]
        adjective_count.times { result.push adjectives[0...adjectives_length] }
      end

      result
    end

    def generate_particles(text)
      index = text_hash(text) % word_count

      result = []
      particles.each do |p|
        result.push p[index % p.size]
        index = (index / p.size).to_i
      end

      result.reverse
    end

    def text_hash(text)
      text = text.to_s
      Digest::MD5.hexdigest(text).to_i(16) * 36413321723440003717
    end

    def adjective_count
      words - 1
    end

    def nouns_length
      Dictionary.noun_lengths[chars]
    end

    def adjectives_length
      Dictionary.adjective_lengths[chars]
    end

    def nouns
      Dictionary.nouns
    end

    def adjectives
      Dictionary.adjectives
    end
  end
end
