class Project
  include Mongoid::Document

  field :title, type: String
  field :points, type: Integer
  embeds_many :stories

  delegate :despised, to: :stories, prefix: true
  delegate :ordered, to: :stories, prefix: true
  delegate :wanted, to: :stories, prefix: true

  validates :title, :points, presence: true
end
