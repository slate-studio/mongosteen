# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'mongosteen/version'

Gem::Specification.new do |s|
  s.name        = 'mongosteen'
  s.version     = Mongosteen::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Alexander Kravets']
  s.email       = 'alex@slatestudio.com'
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/slate-studio/mongosteen'
  s.summary     = 'An easy way to add restful actions'
  s.description = <<-DESC
Mongosteen is a library that helps to easily add restful actions to
mongoid models with support of search, pagination, scopes, history,
json config.
  DESC

  s.rubyforge_project = 'mongosteen'

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency('mongoid',             '~> 4.0')  # orm
  s.add_dependency('inherited_resources', '~> 1.6')  # base actions
  s.add_dependency('kaminari',            '~> 0.16') # pagination
  s.add_dependency('mongoid_search',      '~> 0.3')  # search
  s.add_dependency('has_scope',           '~> 0.6')  # scopes
  s.add_dependency('mongoid-history',     '~> 0.4')  # history
end




