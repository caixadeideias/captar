class StoriesExhibit
  def remaining_points(story_collection, initial = 120)
    "Restando #{points(story_collection, initial)} pontos"
  end

  private

  def points(story_collection, initial)
    return 0 if story_collection.empty?

    initial - story_collection.map(&:points).inject(:+)
  end
end
