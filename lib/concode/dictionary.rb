module Concode
  class Dictionary
    class << self
      def adjectives
        @adjectives ||= File.readlines(path('adjectives'), chomp: true).sort_by!(&:size)
      end

      def nouns
        @nouns ||= File.readlines(path('nouns'), chomp: true).sort_by!(&:size)
      end

      def adjective_lengths
        @adjective_lengths ||= collect_lengths(adjectives)
      end

      def noun_lengths
        @noun_lengths ||= collect_lengths(nouns)
      end

    private

      def path(dictionary)
        File.expand_path("#{dictionary}.txt", __dir__)
      end

      def collect_lengths(source)
        result = {}
        (3..9).each do |len|
          result[len] = source.count { |i| i.size <= len }
        end
        result
      end
    end
  end
end
