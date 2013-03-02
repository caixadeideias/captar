class StoriesExhibit < Exhibit
  def self.remaining_points(story_collection, initial = 120)
    I18n.translate 'stories_exhibits.remaining_points', count: points(story_collection, initial)
  end

  private

  def self.points(story_collection, initial)
    return initial if story_collection.empty?

    initial - story_collection.map(&:points).inject(:+)
  end
end
