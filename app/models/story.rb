class Story
  include Mongoid::Document

  field :title, type: String
  field :points, type: Integer
  field :importance, type: Integer

  validates :points, inclusion: [1, 2, 3, 5, 8, 13, 20]
  validates :importance, inclusion: [1, 2, 3]

  def self.ordered
=begin
    found = collection.aggregate([{
      :'$project' => {
        Story: 1,
        points: 1,
        importance: 1,
        avg: {
          :'$divide' => [{
            :'$add' => ['$points', '$importance']
          }, 2 ]
        }}
    }, { :'$sort' => { avg: 1 } } ])
    Story.find(found.map {|s| s['_id']})
=end
    all.to_a.sort { |a, b| (a.weight <=> b.weight) }
  end

  def weight
    raise Exception if importance.blank? || points.blank?
    (importance + points) / 2.0
  end
end
