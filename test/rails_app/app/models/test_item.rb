class TestItem
  include Mongoid::Document
  include Mongoid::Search

  # attributes
  field :title,       type: String
  field :description, type: String

  scope :test_scope, -> { where title: "Test title" }

  search_in :title, :description

  def test_method
    'Test method'
  end
end
