require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  setup do
    @project = FactoryGirl.create(:project)
    @project.stories << @story = FactoryGirl.create(:story)
  end

  test "should get index" do
    get :index, project_id: @project.to_param
    assert_response :success
  end

  test "should get index with given project" do
    get :index, project_id: @project.to_param
    assert_equal @project, assigns(:project)
  end

  test "should get index with despised stories from the given project" do
    expected = [FactoryGirl.create(:story)]
    Project.any_instance.stubs(:stories_despised).returns(expected)
    get :index, project_id: @project.to_param
    assert_equal expected, assigns(:despised_stories)
  end

  test "should get index with wanted stories from the given project" do
    expected = [FactoryGirl.create(:story)]
    Project.any_instance.stubs(:stories_wanted).returns(expected)
    get :index, project_id: @project.to_param
    assert_equal expected, assigns(:wanted_stories)
  end

  test "should get new" do
    get :new, project_id: @project.to_param
    assert_response :success
  end

  test "should create story" do
    post :create, project_id: @project.to_param, story: { points: @story.points, title: @story.title, importance: @story.importance }

    assert @project.reload.stories.any?
    assert_redirected_to project_story_path(assigns(:project), assigns(:story))
  end

  test "should show story" do
    get :show, project_id: @project.to_param, id: @story
    assert_response :success
  end

  test "should get edit" do
    get :edit, project_id: @project.to_param, id: @story
    assert_response :success
  end

  test "should update story" do
    put :update, project_id: @project.to_param, id: @story, story: { points: @story.points, title: @story.title, importance: @story.importance }
    assert_redirected_to project_story_path(assigns(:project), assigns(:story))
  end

  test "should destroy story" do
    delete :destroy, project_id: @project.to_param, id: @story
    assert @project.reload.stories.empty?
  end

  test "should redirect to project's page after destroy a story" do
    delete :destroy, project_id: @project.to_param, id: @story
    assert_redirected_to @project
  end

  test "should set stories as wanted" do
    Story.any_instance.expects(:want!)
    put :want, project_id: @project.to_param, id: @story
  end

  test "should redirect to project's page after want a story" do
    put :want, project_id: @project.to_param, id: @story
    assert_redirected_to @project
  end

  test "should set stories as despised" do
    Story.any_instance.expects(:despise!)
    put :despise, project_id: @project.to_param, id: @story
  end

  test "should redirect to project's page after despise a story" do
    put :despise, project_id: @project.to_param, id: @story
    assert_redirected_to @project
  end
end
