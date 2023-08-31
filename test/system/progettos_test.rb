require "application_system_test_case"

class ProjectsTest < ApplicationSystemTestCase
  setup do
    @project = projects(:one)
  end

  test "visiting the index" do
    visit projects_url
    assert_selector "h1", text: "Projects"
  end

  test "should create project" do
    visit projects_url
    click_on "New project"

    fill_in "Descrizione", with: @project.descrizione
    fill_in "Dimensione", with: @project.dimensione
    fill_in "Id project", with: @project.id_progetto
    fill_in "Info leader", with: @project.info_leader
    fill_in "Stato", with: @project.stato
    click_on "Create project"

    assert_text "project was successfully created"
    click_on "Back"
  end

  test "should update project" do
    visit project_url(@project)
    click_on "Edit this project", match: :first

    fill_in "Descrizione", with: @project.descrizione
    fill_in "Dimensione", with: @project.dimensione
    fill_in "Id progetto", with: @project.id_progetto
    fill_in "Info leader", with: @project.info_leader
    fill_in "Stato", with: @project.stato
    click_on "Update Progetto"

    assert_text "Progetto was successfully updated"
    click_on "Back"
  end

  test "should destroy Progetto" do
    visit project_url(@project)
    click_on "Destroy this progetto", match: :first

    assert_text "Progetto was successfully destroyed"
  end
end
