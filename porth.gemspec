# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)
require "porth/version"

Gem::Specification.new do |s|
  s.name        = "porth"
  s.version     = Porth::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tate Johnson"]
  s.email       = ["tate@tatey.com"]
  s.homepage    = "https://github.com/tatey/porth"
  s.summary     = %q{Plain Old Ruby Template Handler}
  s.description = %q{Write your views using plain old Ruby}

  s.rubyforge_project = "porbt"

  s.files         = `git ls-files`.split "\n"
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split "\n"
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency 'actionpack', '>= 3.0.0', '< 4.0.0'
  
  s.add_development_dependency 'minitest', '~> 2.6.2'
  s.add_development_dependency 'rake',     '~> 0.9.2'
end
