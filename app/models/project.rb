class Project
  include Mongoid::Document

  field :title, type: String
  field :points, type: Integer
  embeds_many :stories

  validates :title, :points, presence: true
end
