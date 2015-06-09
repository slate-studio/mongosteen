class TestItemsController < ApplicationController
  mongosteen
  has_scope :test_scope, type: :boolean
  json_config methods: [ :test_method ]
end
