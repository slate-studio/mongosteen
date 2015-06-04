class TestItem
  include Mongoid::Document
  include Mongoid::Slug

  # attributes
  field :title,       type: String
  field :description, type: String

  scope :test_scope, -> { where title: "Test title" }

  def test_method
    'Test method'
  end
end




