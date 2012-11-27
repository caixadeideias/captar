require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  setup do
    @story = FactoryGirl.create(:story)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get index with despised stories" do
    expected = [FactoryGirl.create(:story)]
    Story.stubs(:despised).returns(expected)
    get :index
    assert_equal expected, assigns(:despised_stories)
  end

  test "should get index with wanted stories" do
    expected = [FactoryGirl.create(:story)]
    Story.stubs(:wanted).returns(expected)
    get :index
    assert_equal expected, assigns(:wanted_stories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create story" do
    assert_difference('Story.count') do
      post :create, story: { points: @story.points, title: @story.title, importance: @story.importance }
    end

    assert_redirected_to story_path(assigns(:story))
  end

  test "should show story" do
    get :show, id: @story
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @story
    assert_response :success
  end

  test "should update story" do
    put :update, id: @story, story: { points: @story.points, title: @story.title, importance: @story.importance }
    assert_redirected_to story_path(assigns(:story))
  end

  test "should destroy story" do
    assert_difference('Story.count', -1) do
      delete :destroy, id: @story
    end

    assert_redirected_to stories_path
  end

  test "should set stories as wanted" do
    Story.any_instance.expects(:want!)
    put :want, id: @story
  end

  test "should set stories as despised" do
    Story.any_instance.expects(:despise!)
    put :despise, id: @story
  end
end
