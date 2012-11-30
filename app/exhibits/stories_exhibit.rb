class StoriesExhibit < Exhibit
  def self.remaining_points(story_collection, initial = 120)
    "Restando #{points(story_collection, initial)} pontos"
  end

  private

  def self.points(story_collection, initial)
    return initial if story_collection.empty?

    initial - story_collection.map(&:points).inject(:+)
  end
end
