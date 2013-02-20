# encoding: UTF-8
require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  def project
    @project ||= FactoryGirl.create(:project)
  end

  test 'should validate presence of title' do
    subject = FactoryGirl.build(:story, title: nil)
    assert subject.invalid? && subject.errors[:title].present?,
      'should require a title'
  end

  test "should be in a project" do
    subject = FactoryGirl.build(:story)
    subject.project = FactoryGirl.create(:project)
    assert_kind_of Project, subject.project
  end

  # points validation

  test 'should accept the scrum scale numbers'do
    story = FactoryGirl.build(:story)

    story.points = 1
    assert story.valid? && story.errors[:points].empty?,
      'should accept 1'
    story.points = 2
    assert story.valid? && story.errors[:points].empty?,
      'should accept 2'
    story.points = 3
    assert story.valid? && story.errors[:points].empty?,
      'should accept 3'
    story.points = 5
    assert story.valid? && story.errors[:points].empty?,
      'should accept 5'
    story.points = 8
    assert story.valid? && story.errors[:points].empty?,
      'should accept 8'
    story.points = 13
    assert story.valid? && story.errors[:points].empty?,
      'should accept 13'
    story.points = 20
    assert story.valid? && story.errors[:points].empty?,
      'should accept 20'
  end

  test 'should not accept numbers out of scrum scale' do
    story = FactoryGirl.build(:story, points: 11)
    assert story.invalid? && story.errors[:points].present?,
      'should not accept'
  end

  test 'should not accept zero in points attribute' do
    story = FactoryGirl.build(:story, points: 0)
    assert story.invalid? && story.errors[:points].present?,
      'should not accept'
  end

  test 'should not accept points greater than 20' do
    story = FactoryGirl.build(:story, points: 40)
    assert story.invalid? && story.errors[:points].present?,
      'should not accept greater than 20'
  end

  # importance validation

  test 'should accept high priority importance' do
    story = FactoryGirl.build(:story, importance: 1)
    assert story.valid? && story.errors[:importance].empty?,
      'should accept 1'
  end

  test 'should accept mid priority importance' do
    story = FactoryGirl.build(:story, importance: 2)
    assert story.valid? && story.errors[:importance].empty?,
      'should accept 2'
  end

  test 'should accept low priority importance' do
    story = FactoryGirl.build(:story, importance: 3)
    assert story.valid? && story.errors[:importance].empty?,
      'should accept 3'
  end

  test 'should not accept any other number in the importance attribute' do
    story = FactoryGirl.build(:story, importance: 5)
    assert story.invalid? && story.errors[:importance].present?,
      'should not accept any number that is not 1, 2 or 3'
  end

  test 'should set new stories as unwanted' do
    refute Story.new.wanted?
  end

  # scopes

  test 'ordered scope should keep stories with lower points first' do
    project.stories << first = FactoryGirl.create(:story, importance: 1, points: 1)
    project.stories << third = FactoryGirl.create(:story, importance: 1, points: 13)
    project.stories << second = FactoryGirl.create(:story, importance: 1, points: 8)
    assert_equal [first, second, third], project.stories.ordered
  end

  test 'ordered scope should keep stories with greater importance first' do
    project.stories << third = FactoryGirl.create(:story, importance: 3, points: 1)
    project.stories << first = FactoryGirl.create(:story, importance: 1, points: 1)
    project.stories << second = FactoryGirl.create(:story, importance: 2, points: 1)
    assert_equal [first, second, third], project.stories.ordered
  end

  test 'wanted scope should not keep despised stories' do
    project.stories << FactoryGirl.create(:story, wanted: false)
    assert project.stories.wanted.empty?, 'should not include unwanted'
  end

  test 'wanted scope should keep wanted stories' do
    project.stories << FactoryGirl.create(:story, wanted: true)
    assert project.stories.wanted.present?, 'should include wanted'
  end

  test 'despised scope should not keep wanted stories' do
    project.stories << FactoryGirl.create(:story, wanted: true)
    assert project.stories.despised.empty?, 'should not include wanted'
  end

  test 'despised scope should keep despised stories' do
    project.stories << FactoryGirl.create(:story, wanted: false)
    assert project.stories.despised.present?, 'should include despised'
  end

  # instance methods

  test 'weight method returns the average of points and importance' do
    subject = FactoryGirl.create(:story, importance: 2, points: 1)
    assert_equal 1.5, subject.weight
  end

  test 'weight method raises exception when called without points' do
    subject = FactoryGirl.build(:story, importance: nil, points: nil)
    assert_raise(Exception) do
      subject.weight
    end
  end

  test 'string version should concatenate points, importance and title' do
    subject = FactoryGirl.build(:story, title: 'Bla foo', importance: 1, points: 5)
    assert_equal '(5 pontos, alta) Bla foo', subject.to_s
    subject.importance = 2
    assert_equal '(5 pontos, média) Bla foo', subject.to_s
    subject.importance = 3
    assert_equal '(5 pontos, baixa) Bla foo', subject.to_s
  end

  test 'string version should show when story is incomplete' do
    subject = FactoryGirl.build(:story, title: nil, importance: 1, points: 5)
    assert_equal '- incompleta -', subject.to_s
  end

  test 'want! method should update want attribute to true' do
    subject = FactoryGirl.build(:story, wanted: false)
    subject.want!
    assert subject.reload.wanted?
  end

  test 'despise! method should update want attribute to false' do
    subject = FactoryGirl.build(:story, wanted: true)
    subject.despise!
    refute subject.reload.wanted?
  end
end
