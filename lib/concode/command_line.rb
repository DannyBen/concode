require 'optparse'
require 'ostruct'

module Concode
  class CommandLine
    class << self
      def execute(args)
        parser.parse! args
        p options
      end

      def parser
        @parser ||= parser!
      end

      def options
        @options ||= options!
      end

      private

      def options!
        OpenStruct.new words: 2, max_chars: 2
      end

      def parser!
        OptionParser.new do |opts|
          opts.banner = "Usage: #{$0} [options]"

          opts.separator ""
          opts.separator "Options:"

          opts.on("-w", "--words COUNT", "Number of words to generate") do |v|
            options[:words] = v
          end

          opts.on("-m", "--max-chars COUNT", "Max characters per word") do |v|
            options[:max_chars] = v
          end

          opts.on_tail("-h", "--help", "Show this message") do
            puts opts
            exit
          end

          opts.on_tail("--version", "Show version") do
            puts VERSION
            exit
          end
        end
      end

    end

  end
end
