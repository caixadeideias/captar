module StoriesHelper
  def story(story = @story)
    StoriesExhibit.new(story)
  end
end
