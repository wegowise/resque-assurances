# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'resque-assurances/version'

Gem::Specification.new do |s|
  s.name = 'resque-assurances'
  s.version = Resque::Assurances::VERSION
  s.authors = ['Nathan Fixler']
  s.email = ['nathan@fixler.org']
  s.homepage = 'https://rubygems.org/gems/resque-assurances'
  s.license = 'MIT'
  s.summary = 'Provide assurances for resque jobs.'
  s.description = 'Collection of resque plugins that individually provide specific assurances about how resque workers will behave.'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")

  s.add_runtime_dependency 'resque', '>= 1.0', '< 2'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'resque_spec', '~> 0.16'
end
