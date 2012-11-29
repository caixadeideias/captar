require_relative '../test_helper'

class StoriesExhibitTest < ActiveSupport::TestCase
  test 'should provide remaing points of a collection of stories' do
    subject = StoriesExhibit.new
    assert_equal 'Restando 113 pontos', subject.remaining_points([stub(points: 1), stub(points: 6)])
  end

  test 'remaing points returns zero for empty story collections' do
    subject = StoriesExhibit.new
    assert_equal 'Restando 0 pontos', subject.remaining_points([])
  end
end
