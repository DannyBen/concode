lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'concode/version'

Gem::Specification.new do |s|
  s.name        = 'concode'
  s.version     = Concode::VERSION
  s.summary     = 'Generate consistent-codenames from any string'
  s.description = 'Generate consistent-codenames from any string (Heroku style, aka Haiku)'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = ['concode']
  s.homepage    = 'https://github.com/DannyBen/concode'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 3.0'

  s.metadata = {
    'bug_tracker_uri'       => 'https://github.com/DannyBen/concode/issues',
    'source_code_uri'       => 'https://github.com/DannyBen/concode',
    'rubygems_mfa_required' => 'true',
  }
end
