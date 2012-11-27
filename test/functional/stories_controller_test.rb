require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  setup do
    @story = FactoryGirl.create(:story)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stories)
  end

  test "should get index with ordered stories" do
    expected = [FactoryGirl.create(:story)]
    Story.stubs(:ordered).returns(expected)
    get :index
    assert_equal expected, assigns(:stories)
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
end
