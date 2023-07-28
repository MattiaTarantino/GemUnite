require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get projects_url
    assert_response :success
  end

  test "should get new" do
    get new_project_url
    assert_response :success
  end

  test "should create project" do
    assert_difference("Pproject.count") do
      post projects_url, params: { project: { descrizione: @project.descrizione, dimensione: @project.dimensione, id_project: @project.id_project, info_leader: @project.info_leader, stato: @project.stato } }
    end

    assert_redirected_to project_url(Pproject.last)
  end

  test "should show project" do
    get project_url(@project)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_url(@project)
    assert_response :success
  end

  test "should update project" do
    patch project_url(@project), params: { project: { descrizione: @project.descrizione, dimensione: @project.dimensione, id_project: @project.id_project, info_leader: @project.info_leader, stato: @project.stato } }
    assert_redirected_to project_url(@project)
  end

  test "should destroy project" do
    assert_difference("Pproject.count", -1) do
      delete project_url(@project)
    end

    assert_redirected_to projects_url
  end
end
