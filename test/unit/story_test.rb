require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  setup do
    @story = FactoryGirl.build(:story)
  end

  #points validation
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

  #importance validation
  test 'should accept high priority importance' do
    @story.importance = 1
    assert @story.valid? && @story.errors[:importance].empty?,
      'should accept 1'
  end

  test 'should accept mid priority importance' do
    @story.importance = 2
    assert @story.valid? && @story.errors[:importance].empty?,
      'should accept 2'
  end

  test 'should accept low priority importance' do
    @story.importance = 3
    assert @story.valid? && @story.errors[:importance].empty?,
      'should accept 3'
  end

  test 'should not accept any other number in the importance attribute' do
    @story.importance = 5
    assert @story.invalid? && @story.errors[:importance].present?,
      'should not accept any number that is not 1, 2 or 3'
  end
end
