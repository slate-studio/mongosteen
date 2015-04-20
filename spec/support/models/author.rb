class Author
  include Mongoid::Document

  # attributes
  field :name

  # relations
  has_and_belongs_to_many :books
end
