# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'reactor/version'

Gem::Specification.new do |s|
  s.name        = 'reactor'
  s.version     = Reactor::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Alexander Kravets']
  s.email       = 'alex@slatestudio.com'
  s.license     = 'MIT'
  s.homepage    = 'http://slatestudio.com'
  s.summary     = 'An easy way to add restful actions'
  s.description = <<-DESC
Reactor is a library that helps to easily add restful actions to
mongoid models with support of search, pagination, scopes, history,
json config.
  DESC

  s.rubyforge_project = 'reactor'

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency('mongoid')             # orm
  s.add_dependency('inherited_resources') # base actions
  s.add_dependency('kaminari')            # pagination
  s.add_dependency('mongoid_search')      # search
  s.add_dependency('has_scope')           # scopes
  s.add_dependency('mongoid-history')     # history
end




