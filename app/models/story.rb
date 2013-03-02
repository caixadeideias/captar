# encoding: UTF-8
class Story
  include Mongoid::Document

  field :title, type: String
  field :points, type: Integer
  field :importance, type: Integer
  field :wanted, type: Boolean, default: false
  embedded_in :project

  POINTS = [1, 2, 3, 5, 8, 13, 20]

  validates :title, presence: true
  validates :points, inclusion: POINTS
  validates :importance, inclusion: [1, 2, 3]

  def self.ordered(collection = self.all)
    collection.to_a.sort { |a, b| (a.weight <=> b.weight) }
  end

  def self.wanted
    where(wanted: true).ordered
  end

  def self.despised
    where(wanted: false).ordered
  end

  def weight
    raise Exception if importance.blank? || points.blank?
    (importance + points) / 2.0
  end

  def want!
    self.wanted = true
    save
  end

  def despise!
    self.wanted = false
    save
  end

  def to_s
    if valid?
      "(#{points} pontos, #{importance_as_string}) #{title}"
    else
      '- incompleta -'
    end
  end

  private

  def importance_as_string
    case importance
    when 1 then 'alta'
    when 2 then 'média'
    when 3 then 'baixa'
    end
  end
end
