require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

require 'yaml'

include Concode
include Colsole
require_relative 'spec_mixin'

RSpec.configure do |c|
  c.include SpecMixin

  have_codenamize = command_exist? 'codenamize'

  unless have_codenamize
    c.filter_run_excluding :codenamize
    c.after :suite do
      puts "\n\u001b[31mNote: Compatibility tests were skipped since codenamize is not installed\u001b[0m"
    end
  end
end
