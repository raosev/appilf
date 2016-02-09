# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'appilf/version'

Gem::Specification.new do |s|
  s.name         = "appilf"
  s.version      = Appilf::VERSION
  s.required_ruby_version = '>= 1.9.3'
  s.summary      = "A simple Ruby wrapper for Flippa's API"
  s.description  = "Provides quick access to Flippa's API methods exposed to the public"
  s.license = 'MIT'

  s.author       = "Rogelio Alejandro Sevilla"
  s.email        = "rogelio.sevilla1@gmail.com"
  s.homepage     = "https://github.com/rogeliosevilla1/appilf"

  s.require_path = "lib"
  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")


  s.add_dependency('rest-client', '~> 1.4')
  s.add_dependency('json', '~> 1.8')
  s.add_dependency('methodize', '~> 0.3')

  s.add_development_dependency "webmock", "~> 1.22.6"
  s.add_development_dependency "rake", "~> 0.9"
  s.add_development_dependency "rspec", "~> 2.11"
  s.add_development_dependency "yard",  "~> 0.6.0"
  s.add_development_dependency "pry", "~> 0.10.3"
  s.add_development_dependency "coveralls", "~> 0.8"
end
