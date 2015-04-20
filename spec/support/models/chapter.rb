class Chapter
  include Mongoid::Document

  # attributes
  field :title

  # relations
  belongs_to :book
end
