class TestItemsController < ApplicationController
  mongosteen
  has_scope :test_scope, type: :boolean
  has_scope :title_value, :using => [:value], :type => :hash
  json_config methods: [ :test_method ]
end
