lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date'
require 'concode/version'

Gem::Specification.new do |s|
  s.name        = 'concode'
  s.version     = Concode::VERSION
  s.date        = Date.today.to_s
  s.summary     = "Generate consistent-codenames from any string"
  s.description = "Generate consistent-codenames from any string (Heroku style, aka Haiku)"
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = ["concode"]
  s.homepage    = 'https://github.com/dannyben/concode'
  s.license     = 'MIT'
  s.required_ruby_version = ">= 2.2.0"
end
