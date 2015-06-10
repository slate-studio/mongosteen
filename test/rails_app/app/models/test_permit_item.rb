class TestPermitItem
  include Mongoid::Document

  # attributes
  field :title,       type: String
  field :description, type: String
end
