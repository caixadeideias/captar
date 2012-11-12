class Story
  include Mongoid::Document

  field :title, type: String
  field :points, type: Integer
  field :value, type: Integer
end
