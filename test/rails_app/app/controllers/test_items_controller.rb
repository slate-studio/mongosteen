class TestItemsController < ApplicationController
  mongosteen
  has_scope :test_scope
  json_config methods: [ :test_method ]
end
