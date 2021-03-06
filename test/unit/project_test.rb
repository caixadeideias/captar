require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test 'should validate presence of title' do
    subject = FactoryGirl.build(:project, title: nil)
    assert subject.invalid? && subject.errors[:title].present?,
      'should require a title'
  end

  test 'should validate presence of points' do
    subject = FactoryGirl.build(:project, points: nil)
    assert subject.invalid? && subject.errors[:points].present?,
      'should require a number of points'
  end

  test "should have stories" do
    subject = FactoryGirl.create(:project)
    subject.stories << FactoryGirl.create(:story)
    assert_kind_of Story, subject.stories.first
  end

  test 'should validate numericality of points (equals 0)' do
    subject = FactoryGirl.build(:project, points: 0)
    assert subject.invalid? && subject.errors[:points].present?,
      'should require a number of points greater than 0'
  end

   test 'should validate numericality greater than 0 of points' do
    subject = FactoryGirl.build(:project, points: 1)
    assert subject.valid?
  end
end
