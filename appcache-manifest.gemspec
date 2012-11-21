# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "appcache-manifest/version"

Gem::Specification.new do |s|
	s.name        = "appcache-manifest"
	s.version     = Appcache::Manifest::VERSION
	s.platform    = Gem::Platform::RUBY
	s.authors     = ["Antoine Grant"]
	s.email       = ["antoinegrant@gmail.com"]
	s.homepage    = "https://github.com/antoinegrant/appcache-manifest"
	s.date        = Date.today.to_s
	s.summary     = "Convert manifest.yml to application.manifest and add a route to point to it."
	s.description = ""
	s.files       = `git ls-files`.split("\n") - %w[appcache-manifest.gemspec Gemfile]
	s.require_paths = ["lib"]
end
