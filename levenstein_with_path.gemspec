lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'levenstein_with_path/version'

Gem::Specification.new do |s|
  s.name = 'levenstein_with_path'
  s.version = LevensteinWithPath::VERSION

  s.summary = 'Computes Levenstein distance between arrays of tokens, and gives the list of edits'
  s.description = 'Computes Levenstein distance between arrays of tokens, and gives the list of edits'

  s.authors = ['Paul A. Jungwirth']
  s.homepage = 'https://github.com/pjungwir/levenstein_with_path'
  s.email = ['pj@illuminatedcomputing.com']

  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.executables = []
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,fixtures}/*`.split("\n")

  s.add_development_dependency 'rspec', '>= 3.2.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'rubocop'
end
