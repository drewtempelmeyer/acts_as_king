# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "acts_as_king/version"

Gem::Specification.new do |s|
  s.name        = "acts_as_king"
  s.version     = ActsAsKing::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Drew Tempelmeyer"]
  s.email       = ["drewtemp@gmail.com"]
  s.homepage    = "http://github.com/drewtempelmeyer/acts_as_king"
  s.summary     = %q{Hierarchical ActiveRecord models. Inspired by acts_as_tree. Trees are shady.}
  s.description = %q{Hierarchical ActiveRecord models. Inspired by acts_as_tree. Trees are shady.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency 'rails', ['>= 3.0.0']
  s.add_development_dependency 'shoulda'
  s.add_development_dependency 'sqlite3-ruby'
  s.add_development_dependency 'hanna'

end
