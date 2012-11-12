class Story
  include Mongoid::Document

  field :title, type: String
  field :points, type: Integer
  field :importance, type: Integer

  validates :points, inclusion: [1, 2, 3, 5, 8, 13, 20]
  validates :importance, inclusion: [1, 2, 3]
end
