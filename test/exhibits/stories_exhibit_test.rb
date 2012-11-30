require_relative '../test_helper'

class StoriesExhibitTest < ActiveSupport::TestCase
  test 'should provide remaing points of a collection of stories' do
    assert_equal 'Restando 113 pontos', StoriesExhibit.remaining_points([stub(points: 1), stub(points: 6)])
  end

  test 'remaing points returns configured initial for empty story collections' do
    assert_equal 'Restando 100 pontos', StoriesExhibit.remaining_points([], 100)
  end
end
