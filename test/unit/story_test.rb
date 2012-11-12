require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  setup do
    @story = FactoryGirl.build(:story)
  end

  test 'should accept the scrum scale numbers'do
    @story.points = 1
    assert @story.valid? && @story.errors[:points].empty?,
      'should accept 1'
    @story.points = 2
    assert @story.valid? && @story.errors[:points].empty?,
      'should accept 2'
    @story.points = 3
    assert @story.valid? && @story.errors[:points].empty?,
      'should accept 3'
    @story.points = 5
    assert @story.valid? && @story.errors[:points].empty?,
      'should accept 5'
    @story.points = 8
    assert @story.valid? && @story.errors[:points].empty?,
      'should accept 8'
    @story.points = 13
    assert @story.valid? && @story.errors[:points].empty?,
      'should accept 13'
    @story.points = 20
    assert @story.valid? && @story.errors[:points].empty?,
      'should accept 20'
  end

  test 'should not accept numbers out of scrum scale' do
    @story.points = 11
    assert @story.invalid? && @story.errors[:points].present?,
      'should not accept'
  end

  test 'should not accept zero in points attribute' do
    @story.points = 0
    assert @story.invalid? && @story.errors[:points].present?,
      'should not accept'
  end

  test 'should not accept points greater than 20' do
    @story.points = 40
    assert @story.invalid? && @story.errors[:points].present?,
      'should not accept greater than 20'
  end
end
