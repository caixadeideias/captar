require 'test_helper'

class ProjectsHelperTest < ActionView::TestCase
  test "project_title returns the current project title" do
    @project = stub('project', title: 'My personal project')
    assert_equal 'My personal project', project_title
  end

  test "project_title returns Captar when no project is defined" do
    assert_equal 'Captar', project_title
  end

  test "project_title returns Captar with project without title" do
    @project = stub('project', title: nil)
    assert_equal 'Captar', project_title
  end
end
