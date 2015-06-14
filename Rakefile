# encoding: utf-8
require 'rubygems'
require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rdoc/task'

desc 'Default: run tests for all ORMs.'
task default: :test

desc 'Run Mongosteen unit tests.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.warning = false
end
